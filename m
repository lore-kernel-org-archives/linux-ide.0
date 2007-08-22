From: Tejun Heo <htejun@gmail.com>
Subject: Re:
Date: Wed, 22 Aug 2007 11:45:39 +0900
Message-ID: <46CBA353.7090108@gmail.com>
References: <114377ad0708211840i638c4cb4v4187caab39868a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:25919 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbXHVCp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 22:45:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so26932rvb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 19:45:58 -0700 (PDT)
In-Reply-To: <114377ad0708211840i638c4cb4v4187caab39868a12@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: chia-ming liu <chiaming.liu@gmail.com>
Cc: linux-ide@vger.kernel.org, liuc@okstate.edu

chia-ming liu wrote:
> Dear Tejun, I am not very good at linux and just enough to get by. I
> have tried to use your patch by issuing the command 'patch -p1 <
> combined.patch' and I receive this
> 
> msvlsi63:~/libata-tj-2.6.18.1-20061020 # patch -p1 < combined.patch
> can't find file to patch at input line 5
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |Index: work/drivers/scsi/Kconfig
> |===================================================================
> |--- work.orig/drivers/scsi/Kconfig     2006-10-20 10:48:25.000000000 +0900
> |+++ work/drivers/scsi/Kconfig  2006-10-20 10:48:35.000000000 +0900
> --------------------------
> File to patch:
> 
> Then, I opened combined.path and look for line 5
> 
>  source "drivers/scsi/megaraid/Kconfig.megaraid"
> 
> which point out the file I don't have. Am I missing something? I have
> Opensuse 10.2 and Norco DS-1220 disk array which has Silicon Image
> 3726 port multiplier.
> 
> I don't have any driver install but Suse has recognized the PCI card
> with Silicon Image 3124.

OpenSUSE 10.3 Beta contains PMP support.  I think that will be easier.

-- 
tejun
