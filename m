From: Tejun Heo <tj@kernel.org>
Subject: Re: Sr2760-2s-s2 & Sil4723 & pmp
Date: Tue, 15 Dec 2009 17:31:50 +0900
Message-ID: <4B274976.3040303@kernel.org>
References: <20091207114417.GB1863@voyageur.mas.nom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55576 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbZLOIaQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Dec 2009 03:30:16 -0500
In-Reply-To: <20091207114417.GB1863@voyageur.mas.nom.fr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erwan MAS <erwan@mas.nom.fr>
Cc: linux-ide@vger.kernel.org

Hello,

On 12/07/2009 08:44 PM, Erwan MAS wrote:
> I tried to use sr2760-2s-s2 ( http://www.raidon.com.tw/content.php?sno=0000095&p_id=53 ) with linux !
> 
> With
>   kernel 2.6.21           => work 
>   kernel 2.6.26 & 2.6.28  => does not work 
> 
> In 2.26.21 , the device is detect as sata disk , i can access to it !

Do you mean the Config device?

-- 
tejun
