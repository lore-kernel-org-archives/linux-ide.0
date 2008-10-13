From: Scott Beardsley <scott@cse.ucdavis.edu>
Subject: Re: SATA resets via SMART selftest
Date: Mon, 13 Oct 2008 10:18:30 -0700
Message-ID: <48F382E6.6060305@cse.ucdavis.edu>
References: <48EFBD37.8040604@cse.ucdavis.edu> <20081010220820.4ad97574@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.cse.ucdavis.edu ([128.120.246.11]:44243 "EHLO
	mail.cse.ucdavis.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760558AbYJMRSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 13:18:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 63D7290005
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 10:18:53 -0700 (PDT)
Received: from mail.cse.ucdavis.edu ([127.0.0.1])
	by localhost (mail.cse.ucdavis.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 20356-05 for <linux-ide@vger.kernel.org>;
	Mon, 13 Oct 2008 10:18:40 -0700 (PDT)
Received: from [128.120.246.129] (automatic.cse.ucdavis.edu [128.120.246.129])
	by mail.cse.ucdavis.edu (Postfix) with ESMTP id 7864090006
	for <linux-ide@vger.kernel.org>; Mon, 13 Oct 2008 10:18:30 -0700 (PDT)
In-Reply-To: <20081010220820.4ad97574@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox wrote:
> The timeout set on the command expired so the kernel aborted the command
> and recovered the link.

That makes sense. AFAICT the smartctl ioctl commands are completing 
successfully (with a timeout of 6 secs). I think the timeout might be 
with any subsequent ioctl commands but it seems to be triggered when 
smartctl kicks off a test.

For some strange reason I can't get scsi_logging to work correctly 
(likely my fault). Is there a way to log all ioctl's? I compiled the 
kernel with CONFIG_SCSI_LOGGING=y. I tried playing with the 
scsi_logging=all kernel option but no dice. Also I get a write error 
when I try to enable logging on the fly:

# echo "scsi log timeout 7" > /proc/scsi/scsi
-bash: echo: write error: Invalid argument
#

Read on for the poorman's logger (strace).

> Dump the actual SG_IO command block issued and see what timeout and other
> options are set.

I'm using strace and this code (I only changed the timeout)[1] that just 
runs an inquiry with a timeout of 6 secs. I shut down all other active 
daemons and managed to catch an ioctl in the middle of the reset (after 
a few tries). First I ran the smartctl command (v5.36 this time):

# strace -rt -e ioctl smartctl -d ata -t short -r ioctl,10 /dev/sda
smartctl version 5.36 [x86_64-redhat-linux-gnu] Copyright (C) 2002-6 
Bruce Allen
Home page is http://smartmontools.sourceforge.net/


REPORT-IOCTL: DeviceFD=3 Command=IDENTIFY DEVICE
      0.000000 ioctl(3, 0x30d, 0x7fffffe0f930) = 0
      0.000122 ioctl(3, 0x31f, 0x7fffffe0fb30) = 0
REPORT-IOCTL: DeviceFD=3 Command=IDENTIFY DEVICE returned 0

===== [IDENTIFY DEVICE] DATA START (BASE-16) =====
000-015: 5a 0c ff 3f 37 c8 10 00 00 00 00 00 3f 00 00 00
016-031: 00 00 00 00 20 20 20 20 20 20 20 20 20 20 20 20
032-047: 51 39 36 4d 58 59 41 32 00 00 00 00 04 00 4e 53
048-063: 35 30 20 20 20 20 54 53 35 33 30 30 32 33 4e 30
064-079: 20 53 20 20 20 20 20 20 20 20 20 20 20 20 20 20
080-095: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 10 80
096-111: 00 00 00 2f 00 40 00 02 00 02 07 00 ff 3f 10 00
112-127: 3f 00 10 fc fb 00 10 00 ff ff ff 0f 00 00 07 00
128-143: 03 00 78 00 78 00 78 00 78 00 00 00 00 00 00 00
144-159: 00 00 00 00 00 00 1f 00 02 05 00 00 40 00 40 00
160-175: f0 01 29 00 6b 34 01 7d 23 41 69 34 01 bc 23 41
176-191: 7f 40 31 00 31 00 00 00 fe ff 00 00 00 fe 00 00
192-207: 00 00 00 00 00 00 00 00 30 60 38 3a 00 00 00 00
208-223: 00 00 00 00 00 00 00 00 00 50 00 c5 d2 0d 57 1f
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 1e 40
240-255: 1e 40 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 21 00 30 60 38 3a 30 60 38 3a 00 00 02 00 40 01
272-287: 00 01 00 50 06 3c 0a 3c 00 00 3c 00 00 00 08 00
288-303: 00 00 00 00 0f 00 80 02 00 00 00 00 08 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 27 00 80
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 3d 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 20 1c 00 00 00 00 02 00 00 00 10 10 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a5 a2
===== [IDENTIFY DEVICE] DATA END (512 Bytes) =====


REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS
      0.014834 ioctl(3, 0x31f, 0x7fffffe0fb40) = 0
REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS returned 0

REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS CHECK
      0.044981 ioctl(3, 0x31e, 0x7fffffe0fb50) = 0
REPORT-IOCTL: DeviceFD=3 Command=SMART STATUS CHECK returned 0

REPORT-IOCTL: DeviceFD=3 Command=SMART READ ATTRIBUTE VALUES
      0.041645 ioctl(3, 0x31f, 0x7fffffe0fb30) = 0
REPORT-IOCTL: DeviceFD=3 Command=SMART READ ATTRIBUTE VALUES returned 0

===== [SMART READ ATTRIBUTE VALUES] DATA START (BASE-16) =====
000-015: 0a 00 01 0f 00 4b 45 a8 ab d5 01 00 00 00 03 03
016-031: 00 63 63 00 00 00 00 00 00 00 04 32 00 64 64 14
032-047: 00 00 00 00 00 00 05 33 00 64 64 00 00 00 00 00
048-063: 00 00 07 0f 00 64 fd 1a 0b 0d 00 00 00 00 09 32
064-079: 00 64 64 1b 01 00 00 00 00 00 0a 13 00 64 64 00
080-095: 00 00 00 00 00 00 0c 32 00 64 25 14 00 00 00 00
096-111: 00 00 b8 32 00 64 64 00 00 00 00 00 00 00 bb 32
112-127: 00 64 64 00 00 00 00 00 00 00 bc 32 00 64 64 00
128-143: 00 00 00 00 00 00 bd 3a 00 64 64 00 00 00 00 00
144-159: 00 00 be 22 00 48 46 1c 00 1c 1c 00 00 00 c2 22
160-175: 00 1c 28 1c 00 00 00 19 00 00 c3 1a 00 23 20 a8
176-191: ab d5 01 00 00 00 c5 12 00 64 64 00 00 00 00 00
192-207: 00 00 c6 10 00 64 64 00 00 00 00 00 00 00 c7 3e
208-223: 00 c8 c8 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 82 29 7a 02 00 7b
368-383: 03 00 01 00 01 72 02 00 00 00 00 00 00 00 00 00
384-399: 00 00 05 00 50 0b 00 00 04 01 01 01 01 01 01 01
400-415: 01 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 4a bc 2c 73 ed 00 00 00
432-447: 00 00 00 00 01 00 a0 00 0f ba 7c 02 00 00 00 00
448-463: e8 9a 8b 49 0b 00 00 00 00 00 00 00 8d d4 e0 02
464-479: 00 00 00 00 00 00 00 00 9d 00 00 00 00 00 00 00
480-495: 11 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 5d
===== [SMART READ ATTRIBUTE VALUES] DATA END (512 Bytes) =====


REPORT-IOCTL: DeviceFD=3 Command=SMART READ ATTRIBUTE THRESHOLDS
      0.102167 ioctl(3, 0x31f, 0x7fffffe0fb40) = 0
REPORT-IOCTL: DeviceFD=3 Command=SMART READ ATTRIBUTE THRESHOLDS returned 0

===== [SMART READ ATTRIBUTE THRESHOLDS] DATA START (BASE-16) =====
000-015: 01 00 01 2c 00 00 00 00 00 00 00 00 00 00 03 00
016-031: 00 00 00 00 00 00 00 00 00 00 04 14 00 00 00 00
032-047: 00 00 00 00 00 00 05 24 00 00 00 00 00 00 00 00
048-063: 00 00 07 1e 00 00 00 00 00 00 00 00 00 00 09 00
064-079: 00 00 00 00 00 00 00 00 00 00 0a 61 00 00 00 00
080-095: 00 00 00 00 00 00 0c 14 00 00 00 00 00 00 00 00
096-111: 00 00 b8 63 00 00 00 00 00 00 00 00 00 00 bb 00
112-127: 00 00 00 00 00 00 00 00 00 00 bc 00 00 00 00 00
128-143: 00 00 00 00 00 00 bd 00 00 00 00 00 00 00 00 00
144-159: 00 00 be 2d 00 00 00 00 00 00 00 00 00 00 c2 00
160-175: 00 00 00 00 00 00 00 00 00 00 c3 00 00 00 00 00
176-191: 00 00 00 00 00 00 c5 00 00 00 00 00 00 00 00 00
192-207: 00 00 c6 00 00 00 00 00 00 00 00 00 00 00 c7 00
208-223: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
224-239: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
240-255: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
256-271: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
272-287: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
288-303: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
304-319: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
320-335: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
336-351: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
352-367: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
368-383: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
384-399: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
400-415: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
416-431: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
432-447: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
448-463: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
464-479: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
480-495: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
496-511: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 c4
===== [SMART READ ATTRIBUTE THRESHOLDS] DATA END (512 Bytes) =====

=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
Sending command: "Execute SMART Short self-test routine immediately in 
off-line mode".

REPORT-IOCTL: DeviceFD=3 Command=SMART IMMEDIATE OFFLINE InputParameter=1
      0.015623 ioctl(3, 0x31f, 0x7fffffe0f9f0) = 0
REPORT-IOCTL: DeviceFD=3 Command=SMART IMMEDIATE OFFLINE returned 0
Drive command "Execute SMART Short self-test routine immediately in 
off-line mode" successful.
Testing has begun.
Please wait 1 minutes for test to complete.
Test will complete after Mon Oct 13 11:51:41 2008

Use smartctl -X to abort test.
#


Then I ran the inquiry binary until it hung in the middle of an ioctl:


# strace -rt -e ioctl /root/test /dev/sda
      0.000000 ioctl(3, SG_GET_VERSION_NUM, 0x7fff65e00540) = 0
timeout: 6 secs: Success
      0.000299 ioctl(3, SG_IO, {'S', SG_DXFER_FROM_DEV, cmd[6]=[12, 00, 
00, 00, 60, 00], mx_sb_len=32, iovec_count=0, dxfer_len=96, 
timeout=6000, flags=0

... disk resets here ...

, data[96]=["\0\0\5\2[\0\0\0ATA     ST3500320NS     "...], status=00, 
masked_status=00, sb[0]=[], host_status=0, driver_status=0, resid=0, 
duration=77887, info=0}) = 0
Some of the INQUIRY command's response:
     ATA       ST3500320NS       SN05
INQUIRY duration=77887 millisecs, resid=0
#


You can see it hangs for around 78 secs.
Scott
---------------
[1] http://www.faqs.org/docs/Linux-HOWTO/SCSI-Generic-HOWTO.html#PEXAMPLE
