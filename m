From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: If I have a single bad sector, how many failed reads should
	simple dd report?
Date: Sun, 11 Jul 2010 08:58:19 -0400
Message-ID: <AANLkTilPrr81sS0lVluXttfF52yHZFCiaHwWzN2TaVfp@mail.gmail.com>
References: <AANLkTil2Zfhpkq24qrCoHZVx1vlbIPTcDMrZ508yODta@mail.gmail.com>
	<AANLkTimWfp4mLF9DCpxtnnUQsYQ08gXmh491EfhARe1x@mail.gmail.com>
	<4C37CA99.1040104@teksavvy.com>
	<4C37CBB8.1040909@teksavvy.com>
	<1278771271.2911.18.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52554 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab0GKM6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jul 2010 08:58:21 -0400
Received: by iwn7 with SMTP id 7so3745688iwn.19
        for <linux-ide@vger.kernel.org>; Sun, 11 Jul 2010 05:58:20 -0700 (PDT)
In-Reply-To: <1278771271.2911.18.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Mark Lord <kernel@teksavvy.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>

On Sat, Jul 10, 2010 at 10:14 AM, James Bottomley
<James.Bottomley@suse.de> wrote:
> On Fri, 2010-07-09 at 21:24 -0400, Mark Lord wrote:
>> On 09/07/10 09:19 PM, Mark Lord wrote:
>> > On 09/07/10 03:04 PM, Greg Freemyer wrote:
>> > ..
>> >>> When I re-ran it, /var/log/messages reported 10 bad logical bloc=
ks.
>> >>> And even worse, dd reported 20 bad blocks. I examined the data d=
d
>> >>> read and it had 80KB of zero'ed out data. So that's 160 sectors =
worth
>> >>> of data lost because of a single bad sector. At most I was expec=
ting
>> >>> 4KB of zero'ed out data.
>> > ..
>> >
>> > That's just the standard, undesirable result of the current SCSI E=
H
>> > when used with libata for (mainly) desktop computers.
>> >
>> > I have patches (against older kernels) to fix it, but have yet to
>> > get both myself and James B. interested enough simultaneously to
>> > actually get the kernel fixed. :)
>> ..
>>
>> Here (attached and inline below) are my most recent patches for this=
=2E
>> Still outdated, though. =A0These are against the SLES11 2.6.27.19 ke=
rnel:
>>
>> -----------------------------snip----------------------------
>>
>> Stop the SCSI EH from performing tons of retries on unrecoverable me=
dium errors,
>> so that error-handling fails more quickly and we (EMC) avoid unneede=
d node resets.
>>
>> The ugliness of this patch matches the ugliness of SCSI EH.
>> Does *anyone* actually understand this code completely?
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/scsi/scsi_error.c =A0 =A0 2009-06-04 09:46:55.000000=
000 -0400
>> +++ linux/drivers/scsi/scsi_error.c =A0 2009-06-04 12:08:48.00000000=
0 -0400
>> @@ -423,6 +423,52 @@
>> =A0 =A0 =A0 }
>> =A0 }
>>
>> +/*
>> + * The problem with scsi_check_sense(), is that it is (designed to =
be)
>> + * called only after retries are exhausted. =A0But for MEDIUM_ERROR=
s (only)
>> + * we don't want any retries here at all.
>> + *
>> + * So this function below is a clone of the necessary parts from sc=
si_check_sense(),
>> + * to check for unrecoverable MEDIUM_ERRORs when deciding whether t=
o retry or not.
>> + */
>> +static int scsi_unrecoverable_medium_error(struct scsi_cmnd *scmd)
>> +{
>> + =A0 =A0 struct scsi_sense_hdr sshdr;
>> +
>> + =A0 =A0 if (! scsi_command_normalize_sense(scmd, &sshdr))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0; =A0 =A0 =A0 /* no valid sense da=
ta */
>> +
>> + =A0 =A0 if (scsi_sense_is_deferred(&sshdr))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (sshdr.response_code =3D=3D 0x70) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* fixed format */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (scmd->sense_buffer[2] & 0xe0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* descriptor format: look for "stream c=
ommands sense data
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* descriptor" (see SSC-3). Assume singl=
e sense data
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* descriptor. Ignore ILI from SBC-2 REA=
D LONG and WRITE LONG.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((sshdr.additional_length > 3) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (scmd->sense_buffer[8] =3D=3D 0x4)=
 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (scmd->sense_buffer[11] & 0xe0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (sshdr.sense_key) {
>> + =A0 =A0 case MEDIUM_ERROR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (sshdr.asc =3D=3D 0x11 || /* UNRECOVERE=
D READ ERR */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sshdr.asc =3D=3D 0x13 || /* AMNF D=
ATA FIELD */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sshdr.asc =3D=3D 0x14) { /* RECORD=
 NOT FOUND */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //printk(KERN_WARNING "%s:=
 MEDIUM_ERROR\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>
>
>> +
>> =A0 /**
>> =A0 =A0* scsi_eh_completed_normally - Disposition a eh cmd on return=
 from LLD.
>> =A0 =A0* @scmd: =A0 SCSI cmd to examine.
>> @@ -1334,6 +1380,8 @@
>>
>> =A0 =A0 =A0 switch (status_byte(scmd->result)) {
>> =A0 =A0 =A0 case CHECK_CONDITION:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (scsi_unrecoverable_medium_error(scmd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* assume caller has checked sense and=
 determinted
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the check condition was retryable.
>
> The check is redundant: =A0scsi_decide_disposition is where we check =
for
> retries or error handling. =A0If you look, it already picks out your =
three
> cases and returns success for them (meaning pass straight through). =A0=
in
> sd_done() MEDIUM_ERROR means complete immediately.
>
>
>>
>> On encountering a bad sector, report and skip over it,
>> then continue with the remainder of the request.
>> Otherwise we would fail perfectly good sectors,
>> making a bad situation even worse.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> --- old/drivers/scsi/scsi_lib.c =A0 =A0 =A0 2009-06-04 12:26:52.0000=
00000 -0400
>> +++ linux/drivers/scsi/scsi_lib.c =A0 =A0 2009-06-04 14:40:11.000000=
000 -0400
>> @@ -952,6 +952,12 @@
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (sense_valid && !sense_deferred) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (sshdr.sense_key) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case MEDIUM_ERROR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Bad sector. =A0Fail it, and then contin=
ue the rest of the request. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (this_count && scsi_end_request(cmd, -E=
IO, cmd->device->sector_size, 1) =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->retries =3D 0; =A0 =A0=
 =A0 // go around again..
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case UNIT_ATTENTION:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cmd->device->removab=
le) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Detec=
ted disc change. =A0Set a bit
>
> This one's in the wrong place. =A0Normal MEDIUM_ERRORS complete above
> this.
>
> I also don't think the skip is right. =A0We're supposed to communicat=
e to
> block what we've done, and all we have to do that with is good bytes.
> If we skip over a bad sector and try to complete the rest, we've lost
> the error position.
>
> The failure return from Medium error is defined to be the number of
> bytes we actually wrote, which is everything up to the medium error.
>
> James

If you guys have patches you want me to test, I'm happy to do so, but
I urge the team to work on this simple test case.

It may have been this way since day one of libata, but it certainly
looks like a collection of bugs to me.

Again, assuming /dev/sdb is a test drive without valuable data the
test case can be as simple as just:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#create a 1000 sectors of random data starting at sector 1000
dd if=3D/dev/urandom of=3D/dev/sdb bs=3D512 seek=3D1000 count=3D1000

#make a clean copy of the data, starting at sector 0 and going well
past. 4MB total
dd if=3D/dev/sdb of=3Dclean.dd conv=3Dnoerror,sync bs=3D4K count=3D1000

#corrupt a sector in the middle of the test data
hdparm --make-bad-sector 1500 --yes-i-know-what-i-am-doing /dev/sdb

#make another copy of the first 4MB
dd if=3D/dev/sdb of=3Dcorrupt.dd conv=3Dnoerror,sync bs=3D4K count=3D10=
00

#restore the drive sector so it is not permanently lost
hdparm --write-sector 1500 --yes-i-know-what-i-am-doing /dev/sdb

(I choose sector 1500 this time to make the testing process faster.)

cmp -bl clean.dd corrupt.dd > delta.log

Review delta.log for disagrees.  And /var/log/warn for logical block
failures as well as extraneous media errors.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I found:

1) Corruption stated several bytes prior to the corrupt sector
2) With dd using 512 byte blocks, 64 sectors worth of corrupt data in c=
orrupt.dd
3) With dd using 4K blocks, 160 sectors worth of corrupt data in
corrupt.dd.   (I don't know why the difference and I was using a
customized version of dd called dcfldd for this test.)
4) a 50% reduction in throughput based on one bad sector.  I'm not
sure that's a bug, but it is clearly an issue that can be looked at.
You need a much bigger dd run to see that impact.

Thanks
Greg
