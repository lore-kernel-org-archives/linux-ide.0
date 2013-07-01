From: Tejun Heo <tj@kernel.org>
Subject: Re: Data corruption when using INIC-1623TA2 controller
Date: Sun, 30 Jun 2013 23:17:26 -0700
Message-ID: <20130701061726.GA10717@mtj.dyndns.org>
References: <20130627160606.3447.9939.reportbug@storm.xmen.local>
 <20130627165114.GK4752@decadent.org.uk>
 <1372353297.24346.4.camel@phoenix>
 <20130627173142.GM4752@decadent.org.uk>
 <1372375714.330.17.camel@phoenix>
 <1372383087.23847.35.camel@deadeye.wl.decadent.org.uk>
 <1372427725.23094.17.camel@phoenix>
 <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:58624 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab3GAGRc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 02:17:32 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so4409914pbc.2
        for <linux-ide@vger.kernel.org>; Sun, 30 Jun 2013 23:17:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372603764.5155.17.camel@deadeye.wl.decadent.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: 714295@bugs.debian.org, Martin Braure de Calignon <braurede@free.fr>, linux-ide@vger.kernel.org

Hello,

On Sun, Jun 30, 2013 at 03:49:24PM +0100, Ben Hutchings wrote:
> So this does seem to be a fault in either this card or the driver.  Can
> you suggest any further tests that Martin could do?

Unfortunately, I don't have any idea.  That driver never really
matured enough.  I couldn't find enough information and no one from
initio responded, so....

-- 
tejun
