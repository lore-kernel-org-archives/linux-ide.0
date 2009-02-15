From: Mark Lord <mlord@pobox.com>
Subject: Re: SATL support for hdparm?
Date: Sat, 14 Feb 2009 19:17:35 -0500
Message-ID: <49975F1F.8090900@pobox.com>
References: <20090214222114.GI17914@xi.wantstofly.org>
 <49975A6D.4010608@pobox.com> <20090215000603.GK17914@xi.wantstofly.org>
 <49975D28.4050101@pobox.com> <20090215001355.GL17914@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbZBOARj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Feb 2009 19:17:39 -0500
In-Reply-To: <20090215001355.GL17914@xi.wantstofly.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-ide@vger.kernel.org, dgilbert@interlog.com

Lennert Buytenhek wrote:
..
>>> 	[root@heth hdparm-9.10]# ./hdparm -B 254 /dev/sdb
..
> 	ioctl(3, SG_IO, {'S', SG_DXFER_NONE, cmd[12]=[a1, 06, 20, 05, fd, 00, 00, 00, 40, ef, 00, 00], mx_sb_len=32, iovec_count=0, dxfer_len=0, timeout=5000, flags=0, status=02, masked_status=01, sb[22]=[72, 0b, 00, 00, 00, 00, 00, 0e, 09, 0c, 00, 04, 00, fd, 00, 00, 00, 00, 00, 00, 40, 51], host_status=0, driver_status=0x8, resid=0, duration=1, info=0x1}) = 0
> 
> Does that mean the drive doesn't support SET_FEATURES/{05,85} (weird)?
..

The -I (IDENTIFY) flag will tell whether the drive supports Advanced Power 
Management, so try that.

Also, not all drives like 254.  To turn it off, use -B 255 instead.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
