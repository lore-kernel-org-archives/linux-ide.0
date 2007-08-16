From: Tejun Heo <htejun@gmail.com>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Thu, 16 Aug 2007 22:19:24 +0900
Message-ID: <46C44EDC.6050904@gmail.com>
References: <46C1A999.5070109@dastyle.net> <46C441CB.8020805@gmail.com> <46C44A05.9040302@dastyle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:36770 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761490AbXHPNTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 09:19:36 -0400
Received: by rv-out-0910.google.com with SMTP id k20so203161rvb
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 06:19:36 -0700 (PDT)
In-Reply-To: <46C44A05.9040302@dastyle.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jonathan Bastien-Filiatrault <joe@dastyle.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jonathan Bastien-Filiatrault wrote:
> So far, I have managed to patch up the AHCI driver to initialize the
> ICH7 AHCI state machine as the BIOS would do (as per the AHCI spec
> instructions). This involves mapping ABAR and such. So far, I have
> gotten the AHCI driver to detect the chip properly, but it does not
> detect any drives. It looks like I will need to further initialize the
> chip. I think there might be a chance of success, but it will involve
> manually specifying which ports are present via a module parameter.

You probably need to program PCS.

-- 
tejun
