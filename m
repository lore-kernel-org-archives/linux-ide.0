From: Tejun Heo <htejun@gmail.com>
Subject: Re: booting from MD raid using libata
Date: Thu, 16 Aug 2007 19:56:37 +0900
Message-ID: <46C42D65.9030607@gmail.com>
References: <46C2FA67.5060005@gac.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:15811 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761040AbXHPK4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 06:56:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so176997rvb
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 03:56:51 -0700 (PDT)
In-Reply-To: <46C2FA67.5060005@gac.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ethan Sommer <sommere@gac.edu>
Cc: linux-ide@vger.kernel.org

Ethan Sommer wrote:
> I've been trying to diagnose a problem we've been having for a few days
> and I think I've found the problem. (I'm hoping you might have the
> solution.)
> 
> I have a system which has a intel 965 MB and a couple SIL based SATA
> cards one of which is hooked up to a few PMPs.
> 
> If I try to boot the system normally after installing the libata-tj
> patch, it can't find the root partition because MD can't find any raid
> devices because the kernel hasn't detected the SATA partitions yet.

Do you load sd before or after md?

-- 
tejun
