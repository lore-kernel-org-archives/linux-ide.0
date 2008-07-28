From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: IDE S.M.A.R.T. ioctl errors
Date: Mon, 28 Jul 2008 18:16:16 +0200
Message-ID: <9ea470500807280916k7824dc28m169f4c4db65023fa@mail.gmail.com>
References: <20080728060133.GA14007@gollum.tnic>
	 <200807281644.38419.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:47375 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbYG1QQR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 12:16:17 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5818959wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 28 Jul 2008 09:16:16 -0700 (PDT)
In-Reply-To: <200807281644.38419.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jul 28, 2008 at 4:44 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
>
> Hi,
>
> On Monday 28 July 2008, Borislav Petkov wrote:
>
> [...]
>
>> [   32.918048] ide_cmd_ioctl: args[0]: 0xb0, args[1]: 0x1, args[2]: =
0xd5 args[3]: 0x1
>> [   32.918164] hdd: status error: status=3D0x58 { DriveReady SeekCom=
plete DataRequest }
>> [   32.918392] ide: failed opcode was: 0xb0
>> [   32.918491] hdd: drive not ready for command
>> [   32.918618] hdd: status error: status=3D0x58 { DriveReady SeekCom=
plete DataRequest }
>> [   32.918844] ide: failed opcode was: 0xea
>> [   32.918949] hdd: drive not ready for command
>> ...
>>
>> and this is "caused" by
>> ide-use-correct-data-phase-for-smart-read-data-log-in-ide_cmd_ioctl.=
patch. This
>> happens, IMHO, because when you do ATA_CMD_SMART from userspace ioct=
l, one of
>> the cases is that the tf->feature flags have values which are incons=
istent with
>> the ATA/ATAPI v.7 spec (6.54.5 SMART READ DATA):
>>
>> "If the device does not support this command, if SMART is disabled, =
or if the
>> values in the Features, LBA Mid, or LBA High registers are invalid, =
the device
>> shall return command aborted."
>>
>> For example this one:
>>
>> [   30.499581] ide_cmd_ioctl: args[0]: 0xb0, args[1]: 0x1, args[2]: =
0xd1 args[3]: 0x1
>> [   30.516111] hda: task_no_data_intr: status=3D0x58 { DriveReady Se=
ekComplete DataRequest }
>> [   30.516387] ide: failed opcode was: 0xb0
>>
>> However, the case with the SMART_READ_LOG looks correct above: args[=
2] =3D 0xd5
>> which is the tf->feature flag, cmd =3D 0xb0 (ATA_CMD_SMART). This on=
e fails too, though.
>
> Thanks for spotting it.
>
> It seems that ide_cmd_ioctl() ->data_phase change is not as obvious a=
s
> I previously thought.  Since the patch is quite low-prio (it prepares
> the code for future changes) I just dropped it until we learn more ab=
out
> the underlying issues.

How about aborting the ioctl in all those cases when the relevant
registers above contain invalid values
according to the spec? It sounds a pretty sane thing to do...


--=20
Regards/Gru=DF,
Boris
