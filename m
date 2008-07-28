From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE S.M.A.R.T. ioctl errors
Date: Mon, 28 Jul 2008 16:44:38 +0200
Message-ID: <200807281644.38419.bzolnier@gmail.com>
References: <20080728060133.GA14007@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755209AbYG1PCE@vger.kernel.org>
In-Reply-To: <20080728060133.GA14007@gollum.tnic>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday 28 July 2008, Borislav Petkov wrote:

[...]

> [   32.918048] ide_cmd_ioctl: args[0]: 0xb0, args[1]: 0x1, args[2]: 0xd5 args[3]: 0x1
> [   32.918164] hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   32.918392] ide: failed opcode was: 0xb0
> [   32.918491] hdd: drive not ready for command
> [   32.918618] hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> [   32.918844] ide: failed opcode was: 0xea
> [   32.918949] hdd: drive not ready for command
> ...
> 
> and this is "caused" by
> ide-use-correct-data-phase-for-smart-read-data-log-in-ide_cmd_ioctl.patch. This
> happens, IMHO, because when you do ATA_CMD_SMART from userspace ioctl, one of
> the cases is that the tf->feature flags have values which are inconsistent with
> the ATA/ATAPI v.7 spec (6.54.5 SMART READ DATA):
> 
> "If the device does not support this command, if SMART is disabled, or if the
> values in the Features, LBA Mid, or LBA High registers are invalid, the device
> shall return command aborted."
> 
> For example this one:
> 
> [   30.499581] ide_cmd_ioctl: args[0]: 0xb0, args[1]: 0x1, args[2]: 0xd1 args[3]: 0x1
> [   30.516111] hda: task_no_data_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> [   30.516387] ide: failed opcode was: 0xb0
> 
> However, the case with the SMART_READ_LOG looks correct above: args[2] = 0xd5
> which is the tf->feature flag, cmd = 0xb0 (ATA_CMD_SMART). This one fails too, though.

Thanks for spotting it.

It seems that ide_cmd_ioctl() ->data_phase change is not as obvious as
I previously thought.  Since the patch is quite low-prio (it prepares
the code for future changes) I just dropped it until we learn more about
the underlying issues.

Bart
