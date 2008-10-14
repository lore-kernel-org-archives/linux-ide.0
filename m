From: Tejun Heo <tj@kernel.org>
Subject: Re: http://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux
Date: Tue, 14 Oct 2008 15:19:07 +0900
Message-ID: <48F439DB.5010508@kernel.org>
References: <48EE2225.4050006@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48413 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbYJNGVF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Oct 2008 02:21:05 -0400
In-Reply-To: <48EE2225.4050006@gmx.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ele <ele1@gmx.ch>
Cc: linux-ide@vger.kernel.org

Ele wrote:
> Hi
> 
> Please add to your wiki page for WD green drives:
> "workaround: Requires vendor specific tool wdidle3.exe to change the
> configuration.
> The tool can only be obtained via WD support*, _but_ in some cases
> calling it with  paramter /D does not disable automatic unloads.*"

Care to share a bit more details?

-- 
tejun
