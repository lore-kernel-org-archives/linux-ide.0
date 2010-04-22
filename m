From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA driver sata_sil24
Date: Thu, 22 Apr 2010 15:33:55 +0200
Message-ID: <4BD05043.10709@gmail.com>
References: <20100422083226.GA6018@crow.mawsonit.co.uk> <4BD0203C.7010903@gmail.com> <20100422121747.GC6018@crow.mawsonit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62857 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698Ab0DVNeA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 09:34:00 -0400
Received: by wwb24 with SMTP id 24so4799725wwb.19
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 06:33:58 -0700 (PDT)
In-Reply-To: <20100422121747.GC6018@crow.mawsonit.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Mawson <richard@crow.mawsonit.co.uk>
Cc: linux-ide@vger.kernel.org

Hello,

On 04/22/2010 02:17 PM, Richard Mawson wrote:
> As you suggest that this should work, I will persist and see if I can find out
> the problem. I wanted to avoid flogging a dead horse..

The hourse is very alive. :-)

> If you have any suggestions as to what the likely problem is, or
> things to look for I am all ears.

Please try non-xen vanialla kernel and report the failing kernel log.

Thanks.

-- 
tejun
