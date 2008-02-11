From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.25 Regression: DriveStatusError
Date: Mon, 11 Feb 2008 20:51:45 +0100
Message-ID: <200802112051.45395.bzolnier@gmail.com>
References: <200802110927.36109.dex@dragonslave.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760146AbYBKThy@vger.kernel.org>
In-Reply-To: <200802110927.36109.dex@dragonslave.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: webmaster@dragonslave.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Monday 11 February 2008, Daniel Exner wrote:
> Hi!
> 
> Please CC me as I'm not subscribed to any list, thx in advance.
> 
> I tried all -git Kernels since begining of cycle and starting when they finaly 
> compiled fine, they weren't able to mount my root.
> 
> As my laptop with the serial cable is on the run currently I wasn't able to 
> get a trace (perhaps by the we) but error written by hand from screen was 
> this:
> 
> hda: task_no_data_intr: status=0x51 {DriveReady SeekComplete Error}
> hda: task_no_data_intr: error=0x04 {DriveStatusError}
> failed opcode was: 0xe1

[...]

Could you please try 2.6.25-rc1-git1:

http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.25-rc1-git1.bz2

Thanks,
Bart
