From: "Gordon Farquharson" <gordonfarquharson@gmail.com>
Subject: 2.5.25 regression from 2.6.24: smartctl fails to access drive
Date: Wed, 2 Apr 2008 00:00:11 -0600
Message-ID: <97a0a9ac0804012300qeb3e63gbb7e30ffa1ccdb70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:42438 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYDBGAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Apr 2008 02:00:13 -0400
Received: by an-out-0708.google.com with SMTP id d31so650485and.103
        for <linux-ide@vger.kernel.org>; Tue, 01 Apr 2008 23:00:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: bzolnier@gmail.com

On a GLAN Tank (arm/mach-iop32x) smartctl fails with kernel versions
2.6.25-rc1 and later with the following error messages:

hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: 0xb0

smartctl does not fail with kernel version 2.6.24 on this platform.
The version of smartctl is the same for both kernel tests.

This issue has been discussed in
http://bugzilla.kernel.org/show_bug.cgi?id=10086 and based on the
tests conducted, Bartlomiej Zolnierkiewicz wrote,

<--- quote --->

Thanks, from looking at the log:

| hda: tf: feat 0xd8 nsect 0x00 lbal 0x01 lbam 0x4f lbah 0xc2 dev 0x00 cmd 0xb0
| hda: hob: nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00
| hda: tf: feat 0x00 nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00 dev 0x00 cmd 0xb0
| hda: hob: nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00

We got SMART command (cmd 0xb0) with all other registers set to 0x00 and it is
(theoretically) impossible to get it through HDIO_DRIVE_CMD (since
ide_cmd_ioctl() always sets lbam to 0x4f and lbah to 0xc2).  Maybe it was
passed through HDIO_DRIVE_TASK or HDIO_DRIVE_TASKFILE or we have the bug
somewhere (N.B. the behavior of erroing it is correct if the user-space
actually requested such command)...

It seems to be a distinct problem from the one that was hit by Anders and later
fixed by Linus.  Could you try git-bisecting it, please?

<--- end quote --->

Since then, I manually found that the problem commit occurred between
2.6.24 and 2.6.25-rc1. At that point, I started using git-bisect, but
all kernels I have tested so far fail to boot on the GLAN Tank.

Unfortunately, I won't have access to the hardware for the next two
and half weeks, and I have run out of time to track down the commit
that is causing the kernels to fail to boot and therefore also the
commit that is causing smartctl to fail. I wanted to post this message
to the mailing list as a record of the work done to date and so that I
can pick up this problem when I have access to the hardware again.

Sorry for not being able to track this problem down before 2.6.25 is released.

Gordon

-- 
Gordon Farquharson
GnuPG Key ID: 32D6D676
