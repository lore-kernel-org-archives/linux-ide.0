From: Tejun Heo <htejun@gmail.com>
Subject: Re: Need help
Date: Mon, 27 Aug 2007 11:43:12 +0900
Message-ID: <46D23A40.1070406@gmail.com>
References: <002501c7e6c8$a6079170$a378c00a@chia>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:55395 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbXH0CnZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Aug 2007 22:43:25 -0400
Received: by nz-out-0506.google.com with SMTP id s18so976153nze
        for <linux-ide@vger.kernel.org>; Sun, 26 Aug 2007 19:43:24 -0700 (PDT)
In-Reply-To: <002501c7e6c8$a6079170$a378c00a@chia>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chia <liuc@ceat.okstate.edu>
Cc: linux-ide@vger.kernel.org

chia wrote:
> Dear Tejun, I have installed 10.3 Beta 2. It works in the halfway so I
> need to ask your help. To the point download software to the drive and
> installation are  OK. However, when trying to read the data out, it
> stalls for a long time (1~2 min). The same software in normal harddrive
> takes about <10 sec. My drive is Norco DS-1220 disk array which has
> Silicon Image 3726 port multiplier (4 channel). I install all 12 drive
> (different sizes) and soft raid in one big drive (raid 5). When read,
> all light are blink simultaneously (as far as my eyes can
> differentiate). Thanks!

Please post the result of 'dmesg'.  Thanks.

-- 
tejun
