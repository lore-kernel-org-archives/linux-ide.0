From: Tejun Heo <htejun@gmail.com>
Subject: Re: BIOS does not recognize 500GB-disk
Date: Wed, 04 Jul 2007 10:38:45 +0900
Message-ID: <468AFA25.8000400@gmail.com>
References: <20070703225517.GA22912@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:59428 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbXGDBiu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 21:38:50 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1422777nze
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 18:38:49 -0700 (PDT)
In-Reply-To: <20070703225517.GA22912@danisch.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
Cc: linux-ide@vger.kernel.org

Hadmut Danisch wrote:
> Hi,
> 
> just a question:
> 
> I have an older computer with a ASRock K7VT4A Pro mainboard and a VIA sata
> controller. 
> 
> A 320GB Seagate SATA disk worked pretty well with that board, but now I replaced
> it with a 500GB Western Digital SATA, and the BIOS does not recognize that
> new disk, allthough I've updated the BIOS to the latest available version.
> The disk is not available under Linux (latest Ubuntu, 2.6.20). 

Please post boot dmesg.

-- 
tejun
