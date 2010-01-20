From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: retry FS IOs even if it has failed
 with AC_ERR_INVALID
Date: Wed, 20 Jan 2010 14:25:37 -0500
Message-ID: <4B5758B1.3060704@garzik.org>
References: <4B4EC531.2010001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:49910 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258Ab0ATTZj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 14:25:39 -0500
Received: by ywh36 with SMTP id 36so4712228ywh.15
        for <linux-ide@vger.kernel.org>; Wed, 20 Jan 2010 11:25:39 -0800 (PST)
In-Reply-To: <4B4EC531.2010001@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Johannes Stezenbach <js@sig21.net>

On 01/14/2010 02:18 AM, Tejun Heo wrote:
> libata currently doesn't retry if a command fails with AC_ERR_INVALID
> assuming that retrying won't get it any further even if retried.
> However, a failure may be classified as invalid through hardware
> glitch (incorrect reading of the error register or firmware bug) and
> there isn't whole lot to gain by not retrying as actually invalid
> commands will be failed immediately.  Also, commands serving FS IOs
> are extremely unlikely to be invalid.  Retry FS IOs even if it's
> marked invalid.
>
> Transient and incorrect invalid failure was seen while debugging
> firmware related issue on Samsung n130 on bko#14314.
>
>    http://bugzilla.kernel.org/show_bug.cgi?id=14314
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Reported-by: Johannes Stezenbach<js@sig21.net>

applied


