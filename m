From: Larry Baker <baker@usgs.gov>
Subject: Fwd: CF card I/O errors on Linux
Date: Wed, 12 May 2010 14:19:12 -0700
Message-ID: <291D4AE0-82BE-44F8-9AF0-209433D9FA39@usgs.gov>
References: <7B56DFFC-819E-46BA-9D06-B9AB97144AD6@usgs.gov>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gscamnlh01.wr.usgs.gov ([130.118.9.68]:15097 "EHLO
	gscamnlh01.wr.usgs.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab0ELVTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 May 2010 17:19:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

I have been trouble-shooting a misbehaving CF card on Fedora 10 (their =
=20
kernel 2.6.27.41-170.2.117).  It fails in the ATA driver with an =20
ABORT.  I have concluded that the card does not properly implement the =
=20
(PIO) READ/WRITE MULTIPLE commands.  As a result of my work in your =20
libata-core.c code, I have a few suggestions:

1.  I needed to see more of the IDENTIFY DEVICE response, so I =20
modified the probe printout to include words 47, 49, 59, and 80-88, =20
like this:

-			       "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
-			       "85:%04x 86:%04x 87:%04x 88:%04x\n",
+			       "%s: cfg 47:%04x 49:%04x 59:%04x "
+ 			       "80-88:%04x %04x %04x %04x %04x %04x %04x %04x %04x\n",
  			       __func__,
-			       id[49], id[82], id[83], id[84],
-			       id[85], id[86], id[87], id[88]);
+			       id[47], id[49], id[59], id[80], id[81], id[82],
+ 			       id[83], id[84], id[85], id[86], id[87], id[88]);

2.  The device I was having trouble with claims to support multi-=20
sector transfers, with a maximum Sector Count of 1.  There's not much =20
point then, is there?  I suggest adding a test for max >=3D 2 in the =20
conditional where dev->multi_count is assigned:

		/* get current R/W Multiple count setting */
		if ((dev->id[47] >> 8) =3D=3D 0x80 && (dev->id[59] & 0x100)) {
			unsigned int max =3D dev->id[47] & 0xff;
			unsigned int cnt =3D dev->id[59] & 0xff;
+			/* no point unless max >=3D 2 */
+			if (max >=3D 2)
			/* only recognize/allow powers of two here */
			if (is_power_of_2(max) && is_power_of_2(cnt))
				if (cnt <=3D max)
					dev->multi_count =3D cnt;
		}

3.  In the error recovery code (in libata-eh.c?), I suggest a way to =20
recover for devices like the one I've got that improperly implement =20
READ/WRITE MULTI commands:

If the failed command is one of the READ/WRITE MULTI commands (entries =
=20
0-4 in ata_rw_cmds[]), and the device response is ABORT, use your =20
HORKAGE mechanism to set a flag like ATA_HORKAGE_BROKEN_MULTI to skip =20
setting dev->multi_count in libata-core.c (the code in 2., above), =20
i.e., disable multi-sector transfers, then reconfigure the device to =20
disable multi-sector transfers (call ata_dev_configure(), I guess, so =20
the new configuration gets printed out in dmesg) and retry the =20
transfer.  Any future calls to ata_dev_configure() for that device =20
will not attempt to enable multi-sector transfers because the =20
ATA_HORKAGE_BROKEN_MULTI is set:

+		/* don't try to enable R/W multi if it is broken */
+		if (!(dev->horkage & ATA_HORKAGE_BROKEN_MULTI))
		/* get current R/W Multiple count setting */
		if ((dev->id[47] >> 8) =3D=3D 0x80 && (dev->id[59] & 0x100)) {
			unsigned int max =3D dev->id[47] & 0xff;
			unsigned int cnt =3D dev->id[59] & 0xff;
+			/* no point unless max >=3D 2 */
+			if (max >=3D 2)
			/* only recognize/allow powers of two here */
			if (is_power_of_2(max) && is_power_of_2(cnt))
				if (cnt <=3D max)
					dev->multi_count =3D cnt;
		}

Larry Baker
US Geological Survey
650-329-5608
baker@usgs.gov

Begin forwarded message:

> From: Larry Baker <baker@usgs.gov>
> Date: May 11, 2010 10:09:07 PM PDT
> To: Raydon Gordon <rgordon@stec-inc.com>
> Cc: Russ Sell <rwsell@usgs.gov>, Joe Fletcher <jfletcher@usgs.gov>, =20
> Tim MacDonald <tmacdonald@usgs.gov>, Ian Billings <i.billings@reftek.=
com=20
> >
> Subject: Re: CF card I/O errors on Linux
>
> Ron,
>
> I have analyzed the behavior of Fedora 10 Linux with the M2+ CF 9.0 =20
> Rev: K116 CF card and I have concluded that the I/O errors are not =20
> due to a bug in Linux, but that the CF card does not properly =20
> implement the ATA (PIO) READ (WRITE) MULTIPLE command.  It also =20
> returns a malformed value for word 47 (READ/WRITE MULTIPLE support) =20
> from the IDENTIFY DEVICE command.
>
> I reported to you before that the ATA standard says an ABORT error =20
> status means that the READ MULTIPLE command is illegal.  I deduced =20
> that meant the CF card does not support multi-sector transfers.  (I =20
> asked you if that was true, and when you did not contradict me, I =20
> assumed you implicitly confirmed my deduction.)  I speculated that =20
> the Linux driver was not correctly initializing the device =20
> multi_count parameter, which I thought could lead to the illegal use =
=20
> of the READ MULTIPLE command instead of the READ SECTORS command.
>
> I modified the Fedora 10 Linux ATA device driver to initialize the =20
> device multi_count parameter to zero.  That didn't help.  I found =20
> that the CF card was in fact returning device information to the ATA =
=20
> driver that multi-sector transfers were supported.  I also verified =20
> that the ATA driver was correctly reading the multi-sector count =20
> from the CF card.  However, the only way I could ever get the CF =20
> card to work was by forcing the ATA driver to use a READ SECTORS =20
> command instead of a READ MULTIPLE command.
>
> I modified the Fedora 10 Linux ATA device driver to print out the =20
> ATA IDENTIFY DEVICE data words 47, 49, 59, and 80-88 (in hexadecimal)=
:
>
>    ata5.00: ata_dev_configure: cfg 47:0001 49:2b00 59:0101 =20
> 80-88:0078 0000 740a 4004 4000 7429 0004 4003 001f
>
> Word 47 (0001h), bits 0:7 (01h) is the maximum number of sectors for =
=20
> READ/WRITE MULTIPLE commands.  The value is 1 (which means there is =20
> no benefit to READ/WRITE MULTIPLE).
>
> Word 59 (0101h), bit 8 (1) is the "multi-sector transfers enabled" =20
> state.  If multi-sector transfers are enabled (=3D1), the multi-secto=
r =20
> count in bits 0:7 (01h) is the current Sector Count for READ/WRITE =20
> MULTIPLE commands.  The Sector Count is 1, which, since it is also =20
> the maximum allowed, is the only legal value.  If the host does not =20
> alter the Sector Count (to 1, 2, 4, 8, 16, 32, 64, or 128, with a =20
> SET MULTIPLE MODE), the device can use a preferred Sector Count =20
> (which can be 0=3Ddisabled) after power-up/reset for subsequent READ/=
=20
> WRITE MULTIPLE commands.  That is, the host is not required to issue =
=20
> a SET MULTIPLE MODE command if the device enables multi-sector =20
> transfers by default.  The device information returned by the CF =20
> card says multi-sector transfers should work.  (In fact, they are =20
> required to work; see below.)
>
> Recall, the code in the Fedora 10 (Linux kernel version 2.6.27.41) =20
> ATA device driver (function ata_dev_configure() in drivers/ata/=20
> libata-core.c) that sets the device multi_count parameter is:
>
> 		if (dev->id[59] & 0x100)
> 			dev->multi_count =3D dev->id[59] & 0xff;
>
> I speculated the assignment statement was not being executed for the =
=20
> CF card.  That was wrong; it is being executed, and the value 1 is =20
> being assigned to the device multi_count parameter.
>
> I looked at the code in the latest version of the Linux kernel.  It =20
> is different:
>
> 		/* get current R/W Multiple count setting */
> 		if ((dev->id[47] >> 8) =3D=3D 0x80 && (dev->id[59] & 0x100)) {
> 			unsigned int max =3D dev->id[47] & 0xff;
> 			unsigned int cnt =3D dev->id[59] & 0xff;
> 			/* only recognize/allow powers of two here */
> 			if (is_power_of_2(max) && is_power_of_2(cnt))
> 				if (cnt <=3D max)
> 					dev->multi_count =3D cnt;
> 		}
>
> It leaves the device multi_count parameter zero (disabling multi-=20
> sector transfers) if either:
>
>    Word 47, bits 8:15 are not 80h (sanity check of a fixed field =20
> value)
>    Word 59, bit 8 is not set (=3D1) (the device is currently =20
> configured to disable multi-sector transfers)
>    Word 47, bits 0:7 (max) is not a power of 2 (sanity check)
>    Word 59, bits 0:7 (cnt) is not a power of 2 (sanity check)
>    Word 59, bits 0:7 (cnt) (current sector count) is greater than =20
> word 47, bits 0:7 (max) (maximum value allowed for sector count)
>
> Otherwise, it sets the device multi_count parameter to word 59, bits =
=20
> 0:7 (cnt).
>
> I modified the Fedora 10 Linux ATA driver to use the newer code.  =20
> After that, the device multi_count parameter is zero, which disables =
=20
> the use of the READ MULTIPLE command, and the CF card works fine.
>
> I think that is accidental, because:
>
> Word 80 (0078h) sets bits for the ATA version(s) supported.  Bits =20
> 3-6 are set (1).  That means the CF card supports ATA versions 3 =20
> through 6.  All ATA standards since September 1995 (version 3 and =20
> up) have made READ, WRITE, and SET MULTIPLE commands mandatory.  =20
> Examining the values for words 47 and 59 from the IDENTIFY DEVICE =20
> command, we can see the reason the device multi_count parameter was =20
> left set to zero is because bits 8:15 of word 47 are 00h, not 80h.  =20
> The ATA standard versions 3 through 6 (see the portions below) =20
> specify that bits 8:15 of word 47 must (F=3Dfixed value) be 80h.  The=
 =20
> CF card violates this requirement of the ATA standard.  The sanity =20
> check in the Linux ATA driver fails.  This has the inadvertent side =20
> effect of disabling READ MULTIPLE in the Linux ATA driver.  Thus, =20
> the flaw in the value for word 47, bits 8:15 in the device =20
> information coincidentally causes the Linux ATA driver to conceal =20
> the flaw in the support for multi-sector transfers, and the CF card =20
> operates correctly in PIO mode on Linux systems that use kernel =20
> versions later than 2.6.30.
>
> I do not know why the card is not being used in DMA mode on Linux. =20
> Perhaps there is some setup in the Linux PCMCIA Card and Socket =20
> Services that I do not know about.  I also do not know how Windows =20
> XP uses the CF card (READ SECTORS, READ MULTIPLE, or READ DMA).  I =20
> had no trouble reading the CF card on the same hardware when I =20
> booted Windows XP (it is setup to boot either 32-bit Windows XP, 64-=20
> bit Windows XP, or 64-bit Linux).
>
> I was also wrong when I told you earlier that the Linux ATA driver =20
> had nothing to do with reading the CF card with a USB card reader.  =20
> When I got the CF card to work using the CF card-to-PC card adapter, =
=20
> it appeared as a SCSI (/dev/sd) disk.  I thought it would be seen as =
=20
> an IDE (/dev/hd) disk.  The Linux SCSI driver is using the ATA =20
> driver to access the CF card "disk".  This same ATA driver code =20
> might be used when the CF card is plugged into a USB reader.  I =20
> don't know yet.  I will not have a chance to work on this again =20
> until after I return from vacation in a month.
>
> Larry Baker
> US Geological Survey
> 650-329-5608
> baker@usgs.gov
>
> I downloaded the last drafts of each version of the ATA =20
> specifications from the Technical Committee T13, AT Attachment, web =20
> site, http://www.t13.org.  (You have to pay ANSI for copies of the =20
> final ATA standards.)
>
> ATA version 7 (d1532v1r4b ATA-ATAPI-7.pdf)
>
> 6.17.22 Word 47: READ/WRITE MULTIPLE support.
> Bits (7:0) of this word define the maximum number of sectors per =20
> block that the device supports for READ/WRITE MULTIPLE commands. If =20
> the serial interface is implemented, this field shall be set to 16 =20
> or less.
>
> 6.17.28 Word 59: Multiple sector setting
> If bit 8 is set to one, bits (7:0) reflect the number of sectors =20
> currently set to transfer on a READ/WRITE MULTIPLE command. This =20
> field may default to the preferred value for the device (See 6.52).
>
> 6.17.40 Word 80: Major version number
> If not 0000h or FFFFh, the device claims compliance with the major =20
> version(s) as indicated by bits (6:3) being set to one. Values other =
=20
> than 0000h and FFFFh are bit significant. Since ATA standards =20
> maintain downward compatibility, a device may set more than one bit.
>
> 6.17.41 Word 81: Minor version number
> If an implementor claims that the revision of the standard they used =
=20
> to guide their implementation does not need to be reported or if the =
=20
> implementation was based upon a standard prior to the ATA-3 =20
> standard, word 81 shall be 0000h or FFFFh.
>
> ATA version 6 (d1410r3b-ATA-ATAPI-6.pdf)
>
> 47 M F 15-8 80h
>    F 7-0 00h =3D Reserved
>    F 01h-FFh =3D Maximum number of sectors that shall be transferred =
=20
> per interrupt on READ/WRITE MULTIPLE commands
>
> 59 M F 15-9 Reserved
>    V 8 1 =3D Multiple sector setting is valid
>    V 7-0 xxh =3D Current setting for number of sectors that shall be =
=20
> transferred per interrupt on R/W Multiple command
>
> 80 M Major version number
>    0000h or FFFFh =3D device does not report version
>    F 15 Reserved
>    F 14 Reserved for ATA/ATAPI-14
>    F 13 Reserved for ATA/ATAPI-13
>    F 12 Reserved for ATA/ATAPI-12
>    F 11 Reserved for ATA/ATAPI-11
>    F 10 Reserved for ATA/ATAPI-10
>    F 9 Reserved for ATA/ATAPI-9
>    F 8 Reserved for ATA/ATAPI-8
>    F 7 Reserved for ATA/ATAPI-7
>    F 6 1 =3D supports ATA/ATAPI-6
>    F 5 1 =3D supports ATA/ATAPI-5
>    F 4 1 =3D supports ATA/ATAPI-4
>    F 3 1 =3D supports ATA-3
>    X 2 Obsolete
>    X 1 Obsolete
>    F 0 Reserved
>
> 81 M F Minor version number
> 0000h or FFFFh =3D device does not report version
> 0001h-FFFEh =3D see 8.15.41
>
> ATA version 5 (d1321r3-ATA-ATAPI-5.pdf)
>
> 47 X 15-8 80h
>    R 7-0 00h =3D Reserved
>    F 01h-FFh =3D Maximum number of sectors that shall be transferred =
=20
> per interrupt on READ/WRITE MULTIPLE commands
>
> ATA version 4 (d1153r18-ATA-ATAPI-4.pdf)
>
> 47 X 15-8 80h
>    R 7-0 00h =3DReserved
>    F 01h-FFh =3D Maximum number of sectors that shall be transferred =
=20
> per interrupt on READ/WRITE MULTIPLE commands
>
> ATA version 3 (d2008r7b-ATA-3.pdf)
>
> 47 X 15-8 Vendor specific
>    R 7-0 00h =3DReserved
>    F 01h-FFh =3D Maximum number of sectors that can be transferred pe=
r =20
> interrupt on READ/WRITE MULTIPLE commands
>
> Key:
> F =3D the content of the word is fixed and does not change. For =20
> removable media devices, these values may change when media is =20
> removed or changed.
> V =3D the contents of the word is variable and may change depending o=
n =20
> the state of the device or the commands executed by the device.
> X =3D the content of the word is vendor specific and may be fixed or =
=20
> variable.
> R =3D the content of the word is reserved and shall be zero.
>
> On May 9, 2010, at 11:47 AM, Raydon Gordon wrote:
>
>> Hi Larry,
>>
>> Thank you for the explanation of your findings with respect to the =20
>> Linux driver. I agree that not initializing the value of =93device =20
>> multi_count=94 could potential spell disaster. I appreciate your =20
>> willingness to apprise me of what you find after patching the driver=
=2E
>>
>> I regard to the USB to CF card issue, I have engaged our =20
>> engineering team, as previously mentioned. They should be looking =20
>> into this issue during the coming week. I will keep you posted.
>>
>>
>> Best Regards,
>>
>> Raydon Gordon
>> rgordon@stec-inc.com
>>
>> STEC, Inc - Field Application Engineer
>> 2107 N First Street, Suite 415
>> San Jose, CA 95131
>> (800) 367-7330 x8919 (Office)
>> (408) 416-6514 (Cell)
>> (408) 452-7936 (Fax)
>>
>> From: Larry Baker [mailto:baker@usgs.gov]
>> Sent: Friday, May 07, 2010 3:49 PM
>> To: Raydon Gordon
>> Cc: Russ Sell; Joe Fletcher; Tim MacDonald; Ian Billings
>> Subject: Fwd: CF card I/O errors on Linux
>>
>> Ray,
>>
>> I have found the reason for the failure to read your CF card (using =
=20
>> a CF card-to-PCMCIA card adapter) on our Fedora 9 and 10 Linux =20
>> laptops: the ATA device driver in Fedora 9 and 10 is broken.
>>
>> As I mentioned before, the device multi_count setting controls =20
>> whether Linux uses the ATA (PIO) READ MULTIPLE command when it =20
>> reads from the CF card.  The device multi_count setting is a device =
=20
>> configuration setting initialized by the Linux kernel ATA device =20
>> driver (function ata_dev_configure() in drivers/ata/libata-core.c):
>>
>>                 if (dev->id[59] & 0x100)
>>                         dev->multi_count =3D dev->id[59] & 0xff;
>>
>> However, this code alters the device multi_count setting only if =20
>> bit 8 in the IDENTIFY DEVICE word 59 is set (Multiple sector =20
>> setting is valid).  If a device does not support multi-sector =20
>> transfers, bit 8 will be clear, and the device multi_count setting =20
>> will retain its previous value.  The question is, what is that =20
>> value?  Unless it has been initialized somewhere else, it will have =
=20
>> whatever garbage was in the memory location for the device =20
>> multi_count setting when the device configuration data structure =20
>> was allocated.  That would be a bug, and the symptoms would be: =20
>> even though a device responds that it does not support multi-sector =
=20
>> transfers, Linux will use them anyway, and the transfer will fail =20
>> with an ABORT error.  That is exactly what is happening to us.
>>
>> Prior to the code above, the device configuration parameters are =20
>> initialized:
>>
>>         /* initialize to-be-configured parameters */
>>         dev->flags &=3D ~ATA_DFLAG_CFG_MASK;
>>         dev->max_sectors =3D 0;
>>         dev->cdb_len =3D 0;
>>         dev->n_sectors =3D 0;
>>         dev->cylinders =3D 0;
>>         dev->heads =3D 0;
>>         dev->sectors =3D 0;
>>
>> The device multi_count setting does not appear, leading me to =20
>> suspect it has not been initialized to zero anywhere.  Inspection =20
>> of the same section of code in the latest stable release of the =20
>> Linux kernel (2.6.33.3) shows that a line has been added that =20
>> initializes the device muilti_count setting:
>>
>>         /* initialize to-be-configured parameters */
>>         dev->flags &=3D ~ATA_DFLAG_CFG_MASK;
>>         dev->max_sectors =3D 0;
>>         dev->cdb_len =3D 0;
>>         dev->n_sectors =3D 0;
>>         dev->cylinders =3D 0;
>>         dev->heads =3D 0;
>>         dev->sectors =3D 0;
>>         dev->multi_count =3D 0;
>>
>> Fedora 10 Linux uses kernel release 2.6.27.41-170.  The first Linux =
=20
>> release that contains the missing line is 2.6.30.  Thus, any ATA =20
>> device that requires PIO transfers and does not support multi-=20
>> sector transfers will probably fail for Linux kernels older than =20
>> release 2.6.30.  I will try to patch the Linux ATA device drivers =20
>> on our Fedora 9 and Fedora 10 laptops and verify that this explains =
=20
>> the errors we have been getting.
>>
>> CF cards inserted in CF card-to-PCMCIA card adapters into a PCMCIA =20
>> card slot appear to Linux as ATA devices (/dev/hd devices).  CF =20
>> cards inserted in USB CF card readers appear to Linux as SCSI =20
>> devices (/dev/sd devices).  That is not the code I have been =20
>> looking at.  The problems we have encountered reading CF cards =20
>> using USB CF card readers uses different device drivers.  I'll work =
=20
>> on that next when I can find a test setup that works and one that =20
>> fails.
>>
>> Larry Baker
>> US Geological Survey
>> 650-329-5608
>> baker@usgs.gov
>>
>> Begin forwarded message:
>>
>>
>> From: Larry Baker <baker@usgs.gov>
>> Date: May 6, 2010 8:07:22 PM PDT
>> To: Raydon Gordon <rgordon@stec-inc.com>
>> Cc: Russ Sell <rwsell@usgs.gov>, Joe Fletcher <jfletcher@usgs.gov>, =
=20
>> Tim MacDonald <tmacdonald@usgs.gov>
>> Subject: Re: CF card I/O errors on Linux
>>
>> Ray,
>>
>> I have decoded the commands being sent to the CF card.  The Linux =20
>> message log file sequence repeats:
>>
>> ... ata10.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
>> ... ata10.00: cmd c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio =20
>> 16384 in
>> ...         res 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 =20
>> (device error)
>> ... ata10.00: status: { DRDY ERR }
>> ... ata10.00: error: { ABRT }
>> ... ata10.00: configured for PIO0
>> ... ata10: EH complete
>>
>> The cmd=3DC4h command being executed is (PIO) READ MULTIPLE.  The =20
>> arguments are Count=3D20h (32), LBA=3D0, Device=3DE0h (OBSOLETE_BIT_=
15 + =20
>> LBA_BIT + OBSOLETE_BIT13).
>>
>> The res=3D51h response is DRDY (Device Ready) + DRQ (Data Request) +=
 =20
>> ERR (Error).  The error bits=3D04h are ABRT (Abort).
>>
>> The ATA spec (http://www.t13.org/Documents/UploadedDocuments/docs200=
6/D1699r3f-ATA8-ACS.pdf=20
>> ) for READ MULTIPLE (page 155) says:
>>
>> 7.30 READ MULTIPLE - C4h, PIO data-in
>>
>> 7.30.2 Description
>>
>> If the READ MULTIPLE command is received when read multiple =20
>> commands are disabled, the READ MULTIPLE
>> operation shall be rejected with command aborted.
>>
>> The ATA spec for the Abort error bit (page 53) says:
>>
>> 6.2 Error Bits
>>
>> 6.2.1 Abort (ABRT)
>>
>> Error bit 2. Abort shall be set to one if the command is not =20
>> supported. Abort may be set to one if the device is not
>> able to complete the action requested by the command. Abort shall =20
>> also be set to one if an address outside of
>> the range of user-accessible addresses is requested if IDNF is not =20
>> set to one.
>>
>> From this, I conclude that the "M2+ CF 9.0 Rev: K116" CF card does =20
>> not support the ATA (PIO) READ MULTIPLE command.  Is that true?
>>
>> I found the Linux kernel device driver code (function =20
>> ata_rwcmd_protocol() in drivers/ata/libata-core.c) that selects PIO =
=20
>> MULTI vs. PIO transfers.  It tests the ATA device configuration =20
>> field "multi_count" to decide whether to use (PIO) multi-sector =20
>> transfers.  multi_count is set by the Linux kernel ATA device =20
>> driver (function ata_dev_configure(), also in drivers/ata/libata-=20
>> core.c):
>>
>>                 if (dev->id[59] & 0x100)
>>                         dev->multi_count =3D dev->id[59] & 0xff;
>>
>> This code tests whether bit 8 (Multiple sector setting is valid; =20
>> see page 92 in the ATA spec) is set in id[59] (word 59 of the =20
>> response to the IDENTIFY DEVICE command), and, if so, sets the =20
>> value of multi_count to the (presumably non-zero) value in the =20
>> lower 8 bits in id[59] (Current setting for number of logical =20
>> sectors that shall be transferred per DRQ data block on READ/WRITE =20
>> Multiple commands).
>>
>> From this, I conclude that the "M2+ CF 9.0 Rev: K116" CF card is =20
>> responding to the DEVICE INQUIRY command that it does support the =20
>> ATA (PIO) READ MULTIPLE command.  Is that true?
>>
>> If both these conclusions are true, they are inconsistent.  Do you =20
>> agree with my conclusions?  Do you have any way to test this =20
>> hypothesis?
>>
>> Larry Baker
>> US Geological Survey
>> 650-329-5608
>> baker@usgs.gov
>>
>> On May 6, 2010, at 4:38 PM, Raydon Gordon wrote:
>>
>>
>> Larry,
>>
>> I will have to check.
>>
>> Would it be possible for you to send me a photo of the backside of =20
>> the card, which contains version and part number information?
>>
>> Also, which brand and model notebook computer are you using?
>>
>>
>> Thanks!
>>
>>
>> Best Regards,
>>
>> Raydon Gordon
>> rgordon@stec-inc.com
>>
>> STEC, Inc - Field Application Engineer
>> 2107 N First Street, Suite 415
>> San Jose, CA 95131
>> (800) 367-7330 x8919 (Office)
>> (408) 416-6514 (Cell)
>> (408) 452-7936 (Fax)
>>
>>
>> -----Original Message-----
>> From: Larry Baker [mailto:baker@usgs.gov]
>> Sent: Thursday, May 06, 2010 4:32 PM
>> To: Raydon Gordon
>> Subject: Re: CF card I/O errors on Linux
>>
>> Ray,
>>
>> Do you have any laptop Linux systems in house with PCMCIA card slots=
?
>> I can send you a CF card-to-PCMCIA card adapter that I have tried (I
>> tried 3 or 4 of them).
>>
>> Also, which distributions/versions of Linux do you use?  I believe =20
>> the
>> two systems we have (both laptops) run Fedora: one runs Fedora 9, th=
e
>> other runs Fedora 10.
>>
>> Larry Baker
>> US Geological Survey
>> 650-329-5608
>> baker@usgs.gov
>>
>> On May 6, 2010, at 4:26 PM, Raydon Gordon wrote:
>>
>> > Ok, Larry. Since we have not seen this failure in-house on the =20
>> Linux
>> > systems we run, I think it is best to look at the CF card reader. =
=20
>> At
>> > least this way, we should be able to replicate the problem and =20
>> track
>> > down the root cause.
>> >
>> > It is no more difficult for us to diagnose this failure on a =20
>> "cheap"
>> > card reader than it would be on a full-fledged system. We use an
>> > interposer card and a bus analyzer, so there should not be a =20
>> problem.
>> >
>> > Best Regards,
>> >
>> > Raydon Gordon
>> > rgordon@stec-inc.com
>> >
>> > STEC, Inc - Field Application Engineer
>> > 2107 N First Street, Suite 415
>> > San Jose, CA 95131
>> > (800) 367-7330 x8919 (Office)
>> > (408) 416-6514 (Cell)
>> > (408) 452-7936 (Fax)
>> >
>> > -----Original Message-----
>> > From: Larry Baker [mailto:baker@usgs.gov]
>> > Sent: Thursday, May 06, 2010 11:24 AM
>> > To: Raydon Gordon
>> > Subject: Re: CF card I/O errors on Linux
>> >
>> > Ray,
>> >
>> > No problem.  I'll try to spend some time to decode the error =20
>> messages
>> > I included for you.  Note: the errors I sent were not using an CF =
=20
>> card
>> > reader, but a CF card-to-PCMCIA card adapter, which, I believe, =20
>> is not
>> > an active device.  That is, it passes the pins on the CF card to =20
>> the
>> > proper pins in a PCMCIA card slot.  Presumably, that setup should =
=20
>> have
>> > worked, and should be simpler to diagnose than a (likely, cheap) C=
=46
>> > card reader.
>> >
>> > Larry Baker
>> > US Geological Survey
>> > 650-329-5608
>> > baker@usgs.gov
>> >
>> > On May 5, 2010, at 8:19 PM, Raydon Gordon wrote:
>> >
>> >> Larry,
>> >>
>> >> Sorry for the delay in responding. We are currently in the proces=
s
>> >> of investigating the alleged CF card reader compatibility issue.
>> >>
>> >> At this time, the root cause has not been identified as we have =20
>> not
>> >> been able to witness the problem first hand. I'm not saying that =
=20
>> it
>> >> doesn't exist, just that until now we have not seen a problem wit=
h
>> >> any CF card readers. I have purchased a card reader suspected of
>> >> exhibiting this issue and we will begin examining its interaction
>> >> with the new STEC CF cards shortly.
>> >>
>> >> We will be able to provide more insight once our investigation is
>> >> complete. At this time I do not have an ETA, however, I can assur=
e
>> >> you that this reported problem is being investigated.
>> >>
>> >> Best Regards,
>> >>
>> >> Raydon Gordon
>> >> rgordon@stec-inc.com
>> >>
>> >> STEC, Inc - Field Application Engineer
>> >> 2107 N First Street, Suite 415
>> >> San Jose, CA 95131
>> >> (800) 367-7330 x8919 (Office)
>> >> (408) 416-6514 (Cell)
>> >> (408) 452-7936 (Fax)
>> >>
>> >> -----Original Message-----
>> >> From: Jesse Molina
>> >> Sent: Monday, April 19, 2010 3:45 PM
>> >> To: Larry Baker; Mark Swiney
>> >> Cc: Raydon Gordon
>> >> Subject: RE: CF card I/O errors on Linux
>> >>
>> >> Hi Larry,
>> >>
>> >> I am cc'ing Raydon Gordon who is our local FAE. Raydon can take a
>> >> look at things and provide some insight. Thanks.
>> >>
>> >> Best Regards,
>> >> Jesse
>> >>
>> >> Jesse Molina
>> >> Field Sales Engineer
>> >> STEC, Inc.
>> >> Tel: 800-367-7330 x 8916
>> >> Cell: 408-605-5583
>> >> Website: www.stec-inc.com
>> >>
>> >>
>> >> -----Original Message-----
>> >> From: Larry Baker [mailto:baker@usgs.gov]
>> >> Sent: Monday, April 19, 2010 12:04 PM
>> >> To: Mark Swiney; Jesse Molina
>> >> Subject: CF card I/O errors on Linux
>> >>
>> >> We have several M2+ CF 9.0 Rev: K116 cards.  They were supplied =20
>> to us
>> >> by an instrument manufacturer (Refraction Technology) to record
>> >> seismic data.  We use either USB CF card readers or CF-to-PCCARD
>> >> adapters to connect the CF cards to Linux laptops for playback.  =
=20
>> They
>> >> seem to be very temperamental.  They work with some USB CF card
>> >> readers, but not with others.  Sometimes they take an =20
>> excruciatingly
>> >> long time to play back.  I have uniformly bad luck using them wit=
h
>> >> any
>> >> of the many (5V and low-voltage keyed) CF-to-PCCARD adapters.  =20
>> (The
>> >> Linux kernel messages are below.  I have not tried to decode the
>> >> SCSI/
>> >> ATA responses.)  The problems do not seem to appear when we use
>> >> Windows XP -- only Linux -- I don't know why.  However, our data
>> >> management systems are all Linux; we do not use Windows.  The =20
>> Linux
>> >> systems I have tried are Fedora 9 and 10.  We do not have this
>> >> problem
>> >> with other brands of CF cards (e.g., Kingston).  However, our
>> >> instrument supplier uses your cards.  Do your engineers have any
>> >> comments or suggestions?
>> >>
>> >> Larry Baker
>> >> US Geological Survey
>> >> 650-329-5608
>> >> baker@usgs.gov
>> >>
>> >> Portions of the Fedora Linux 10 /var/log/messages file with error
>> >> messages and drive status information following insertion of CF-=20
>> to-
>> >> PCCARD adapter:
>> >>
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:20:00:00:00/00:00:00:00:00/e0 tag 0 pio 16384 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:20:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Result:
>> >> hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Sense Key : =20
>> Aborted
>> >> Command [current] [descriptor]
>> >> Apr 19 04:45:42 necv50 kernel: Descriptor sense data with sense
>> >> descriptors (in hex):
>> >> Apr 19 04:45:42 necv50 kernel:        72 0b 00 00 00 00 00 0c 00 =
=20
>> 0a
>> >> 80
>> >> 00 00 00 00 00
>> >> Apr 19 04:45:42 necv50 kernel:        00 00 00 00
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Add. Sense: No
>> >> additional sense information
>> >> Apr 19 04:45:42 necv50 kernel: end_request: I/O error, dev sdb,
>> >> sector 0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: exception Emask 0x0 =20
>> SAct 0x0
>> >> SErr 0x0 action 0x0
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: cmd
>> >> c4/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
>> >> Apr 19 04:45:42 necv50 kernel:         res
>> >> 51/04:08:00:00:00/00:00:00:00:00/e0 Emask 0x1 (device error)
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: status: { DRDY ERR }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: error: { ABRT }
>> >> Apr 19 04:45:42 necv50 kernel: ata10.00: configured for PIO0
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Result:
>> >> hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE,SUGGEST_OK
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Sense Key : =20
>> Aborted
>> >> Command [current] [descriptor]
>> >> Apr 19 04:45:42 necv50 kernel: Descriptor sense data with sense
>> >> descriptors (in hex):
>> >> Apr 19 04:45:42 necv50 kernel:        72 0b 00 00 00 00 00 0c 00 =
=20
>> 0a
>> >> 80
>> >> 00 00 00 00 00
>> >> Apr 19 04:45:42 necv50 kernel:        00 00 00 00
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Add. Sense: No
>> >> additional sense information
>> >> Apr 19 04:45:42 necv50 kernel: end_request: I/O error, dev sdb,
>> >> sector 0
>> >> Apr 19 04:45:42 necv50 kernel: ata10: EH complete
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] 3844512 512-byte
>> >> hardware sectors (1968 MB)
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Write Protect =20
>> is off
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Write cache:
>> >> enabled,
>> >> read cache: enabled, doesn't support DPO or FUA
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] 3844512 512-byte
>> >> hardware sectors (1968 MB)
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Write Protect =20
>> is off
>> >> Apr 19 04:45:42 necv50 kernel: sd 9:0:0:0: [sdb] Write cache:
>> >> enabled,
>> >> read cache: enabled, doesn't support DPO or FUA
>> >>
>> >>
>> >> PROPRIETARY-CONFIDENTIAL INFORMATION INCLUDED
>> >>
>> >> This electronic transmission, and any documents attached hereto, =
=20
>> may
>> >> contain confidential, proprietary and/or legally privileged
>> >> information. The information is intended only for use by the
>> >> recipient named above. If you received this electronic message in
>> >> error, please notify the sender and delete the electronic message=
=2E
>> >> Any disclosure, copying, distribution, or use of the contents of
>> >> information received in error is strictly prohibited, and =20
>> violators
>> >> will be pursued legally.
>> >
>> >
>> > PROPRIETARY-CONFIDENTIAL INFORMATION INCLUDED
>> >
>> > This electronic transmission, and any documents attached hereto, =20
>> may
>> > contain confidential, proprietary and/or legally privileged
>> > information. The information is intended only for use by the
>> > recipient named above. If you received this electronic message in
>> > error, please notify the sender and delete the electronic message.
>> > Any disclosure, copying, distribution, or use of the contents of
>> > information received in error is strictly prohibited, and violator=
s
>> > will be pursued legally.
>>
>>
>>
>> PROPRIETARY-CONFIDENTIAL INFORMATION INCLUDED
>>
>> This electronic transmission, and any documents attached hereto, =20
>> may contain confidential, proprietary and/or legally privileged =20
>> information. The information is intended only for use by the =20
>> recipient named above. If you received this electronic message in =20
>> error, please notify the sender and delete the electronic message. =20
>> Any disclosure, copying, distribution, or use of the contents of =20
>> information received in error is strictly prohibited, and violators =
=20
>> will be pursued legally.
>>
>>
>>
>>
>> PROPRIETARY-CONFIDENTIAL INFORMATION INCLUDED
>>
>> This electronic transmission, and any documents attached hereto, =20
>> may contain confidential, proprietary and/or legally privileged =20
>> information. The information is intended only for use by the =20
>> recipient named above. If you received this electronic message in =20
>> error, please notify the sender and delete the electronic message. =20
>> Any disclosure, copying, distribution, or use of the contents of =20
>> information received in error is strictly prohibited, and violators =
=20
>> will be pursued legally.
>

