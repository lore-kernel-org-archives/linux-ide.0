From: Tejun Heo <tj@kernel.org>
Subject: Re: [Affected devices] Frequent head unload under Linux
Date: Wed, 01 Oct 2008 12:02:28 +0900
Message-ID: <48E2E844.4070200@kernel.org>
References: <48E1E916.9080202@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53114 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbYJADEG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Sep 2008 23:04:06 -0400
In-Reply-To: <48E1E916.9080202@inwind.it>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Diego Rondini <panda84@inwind.it>
Cc: linux-ide@vger.kernel.org

Diego Rondini wrote:
> As asked in this page:
> http://ata.wiki.kernel.org/index.php/Known_issues
> I report you of two notebook with this issue.
> 
> Unfortunately I haven't access to these notebooks anymore (I installed
> Linux in an install party) so I cannot attach the output of the several
> commands.
> 
> Both of them did very frequent unloads, for sure more than 5 per minute,
> but maybe even more. So that's more than 180 per hour!
> 
> The notebook were very different, the first was a 5 years old HP Compaq
> NX 9005 with a 30GB drive:
> http://h18000.www1.hp.com/products/quickspecs/11602_na/11602_na.HTML#Storage
> 
> Probably the drive was a Hitachi model:
> http://www.itreviews.co.uk/hardware/h504.htm
> 
> The other one was a brand new HP Compaq F760EL with a 120GB drive, but I
> didn't managed to know which kind of drive it's using...
> 
> Sorry for the incomplete informations provided, hope it's better than
> nothing.

Thanks but I can't really add the entry without knowing more
information.  I'm trying to come up with more automatic solution so all
these may be able to go away in some time.

Thanks.

-- 
tejun
