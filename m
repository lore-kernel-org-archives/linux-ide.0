From: Tejun Heo <tj@kernel.org>
Subject: Re: GA-MA790FX-DS5 SATA ahci NCQ erros on Jmicron 20360/20363 	(JMB363)
 kernel 2.6.25-2 Debian/Lenny
Date: Sat, 30 Aug 2008 13:00:22 +0200
Message-ID: <48B92846.7050004@kernel.org>
References: <g8p6po$nm$1@ger.gmane.org> <48B0916C.4080805@garzik.org> <g8q9mg$v2p$1@ger.gmane.org> <WorldClient-F200808241844.AA44240046@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38903 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbYH3LBi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2008 07:01:38 -0400
In-Reply-To: <WorldClient-F200808241844.AA44240046@butn.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: xerces8 <xerces8@butn.net>
Cc: Sergey Spiridonov <sena@hurd.homeunix.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

xerces8 wrote:
> I have a JMB363 myself and it has its share of problems.
> I would say it is buggy hardware. (why would they otherwise
> release a new windows driver every week ? if not to workaround
> bugs in HW ;-)

Well, FWIW, JMB ahci's are one of my favorites and usually very well
behaved.

> My WD MyBook Studio Edition 500 GB external eSATA drive does not
> work on the JMB363 correctly no matter what I try. Both
> under linux and windows. I think the best was 30 minutes of
> (apparent) error free operation under windows.

This one is being discussed both with JMB and WD.  It seems the bridge
chip used in the WD external drives is somehow incompatible with the
JMB ahci's.  Don't know whose fault it is or how it can be worked
around yet.  The issue is being tracked in the following bugzilla.

  http://bugzilla.kernel.org/show_bug.cgi?id=9913

-- 
tejun
