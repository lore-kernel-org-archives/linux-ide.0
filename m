From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: How does libata handles an 'ATA_ABORTED' error?
Date: Thu, 15 Dec 2011 12:38:48 -0600
Message-ID: <CADLC3L2MbPsoDuEMHeOiitU_NvARasKgaBCxdijgX=F744XyGA@mail.gmail.com>
References: <201112140948.03859.jbe@pengutronix.de>
	<4EE98AF4.7090509@gmail.com>
	<201112151201.15044.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32812 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504Ab1LOSit convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Dec 2011 13:38:49 -0500
Received: by ghbz12 with SMTP id z12so1754436ghb.19
        for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2011 10:38:49 -0800 (PST)
In-Reply-To: <201112151201.15044.jbe@pengutronix.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: linux-ide@vger.kernel.org

On Thu, Dec 15, 2011 at 5:01 AM, Juergen Beisert <jbe@pengutronix.de> w=
rote:
> Hi Robert,
>
> Robert Hancock wrote:
>> On 12/14/2011 02:48 AM, Juergen Beisert wrote:
>> > I have a CF card running in true-ide mode connected to regular PC.=
 This
>> > CF card does wear leveling of its flash memory internally like eve=
ry
>> > other CF card. With one exception: When the CF's firmware detects =
a
>> > broken NAND page while writing a sector, it moves around the remai=
ning
>> > (good) data to other pages. To do this job it must discard the alr=
eady
>> > transmitted sector data in its SRAM, because it needs this SRAM to=
 move
>> > around the other flash memory data.
>> >
>> > After the movement the firmware signals an 'ATA_ERR' in the status
>> > register and an 'ATA_ABORTED' in the error register to force the h=
ost to
>> > repeat to write the same data again (next time it will be successf=
ull due
>> > to internal wear leveling is already done).
>> >
>> > As we see data lost when the systems are running in production, I'=
m now
>> > trying to find out if the libata/SCSI layer really repeats the sec=
tor
>> > write for this case and does the expected (or required) things. Bu=
t I'm
>> > lost in these software layers and their error path.
>> >
>> > I found (in Documentation/DocBook/libata.tmpl):
>> >
>> > "This is indicated by UNC bit in the ERROR register. =A0ATA
>> > devices reports UNC error only after certain number of
>> > retries cannot recover the data, so there's nothing much
>> > else to do other than notifying upper layer."
>> >
>> > which sounds to me as no repeat will happen for write errors, but
>> > the 'ATA_UNC' bit is not used to signal the "wear leveling case" s=
hown
>> > above.
>>
>> That seems like incorrect behavior by the device, ABRT is normally u=
sed
>> to indicate an invalid or unsupported command. UNC would likely be m=
ore
>> appropriate. But I don't think it ultimately makes a difference in t=
his
>> case.
>
> Okay.
>
>> > As far as I understand the ATA errors are transformed to SCSI erro=
rs and
>> > then handled in the SCSI layer. But the documentation tells me it =
is not
>> > easy to always find an adequate SCSI error for an ATA error. So, I=
'm not
>> > sure if for the "wear leveling case" the SCSI layer receives a "va=
luable"
>> > error message.
>>
>> =A0From what I can see the SCSI error that gets returned in this cas=
e is
>> just an "aborted command" error.
>>
>> > Does anybody can give me a hint, what really happens when the atta=
ched
>> > drive signals an 'ATA_ABORTED'? Does the libata/SCSI give up in th=
is
>> > case, or will it repeat the command?
>>
>> I don't know that the SCSI or block layers really pay much attention=
 to
>> the error code in this case - I think it would always attempt some r=
etries.
>
> As far as I understand the problem of this kind of errors is for the =
multi
> sector write case. The framework does not know what sectors fails, so=
 the
> question is: does it repeat the whole multi sector sequence or what e=
lse it
> does?

The entire request should get retried.

>
>> Certainly any of these errors would result in error messages showing=
 up
>> in dmesg. Are you seeing any of this?
>
> Are they enabled by default? Or more like debug messages? We see brok=
en
> filesystems and data lost, but currently no related messages in the k=
ernel's
> log. This could mean there are no such failures or the messages are n=
ot
> enabled.

They should always be enabled. If you don't get any, then presumably
the device is not raising any errors.
