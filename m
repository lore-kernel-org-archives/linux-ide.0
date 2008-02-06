From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-pci-generic: kill the unused ifdef/endif/MODULE code
Date: Wed, 6 Feb 2008 02:47:59 +0100
Message-ID: <200802060248.00319.bzolnier@gmail.com>
References: <1201942356-26897-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:11561 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759477AbYBFCAm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 21:00:42 -0500
Received: by ik-out-1112.google.com with SMTP id c28so338818ika.5
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 18:00:38 -0800 (PST)
In-Reply-To: <1201942356-26897-1-git-send-email-crquan@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 02 February 2008, Denis Cheng wrote:
> with module_param macro, the __setup code can be killed now:
> 	const __setup("all-generic-ide", ide_generic_all_on);
> 
> and the module name "generic.ko" is not descriptive to its functionality,
> can be changed in Makefile, the "ide-pci-generic.ko" is better.
> 
> the ide-pci-generic.all-generic-ide parameter also documented
> in Documentation/kernel-parameters.txt
> 
> Signed-off-by: Denis Cheng <crquan@gmail.com>

applied, thanks

PS the other patch will take same more time to review
