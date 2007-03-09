From: Tejun Heo <htejun@gmail.com>
Subject: Re: OOPS with 2.6.21rc2-git (ata: conflict with ide0/1)
Date: Fri, 09 Mar 2007 19:31:56 +0900
Message-ID: <45F1379C.9090609@gmail.com>
References: <45EC9A67.8070204@intel.com> <45EFC3D1.208@gmail.com> <45EFDEF6.7000909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:42644 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993105AbXCIKb6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 05:31:58 -0500
Received: by nz-out-0506.google.com with SMTP id s1so732832nze
        for <linux-ide@vger.kernel.org>; Fri, 09 Mar 2007 02:31:57 -0800 (PST)
In-Reply-To: <45EFDEF6.7000909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

Jeff Garzik wrote:
> Which patch?
> 
> Since this affects libata directly, and since devres came in via libata,
> I would rather that libata bugs not get /too/ blocked by patches in
> other trees.

This one.

  http://article.gmane.org/gmane.linux.kernel/495515

-- 
tejun
