From: =?utf-8?b?RnJhbsOnb2lzLUp1bGllbg==?= Marbaud <fbourget@irisa.fr>
Subject: Re: Slow perfs with IDE SSD
Date: Thu, 13 Jul 2006 08:45:30 +0000 (UTC)
Message-ID: <loom.20060713T104350-271@post.gmane.org>
References: <loom.20060712T102252-777@post.gmane.org> <44B52182.3020008@gmail.com> <44B52439.80408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:12996 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751506AbWGMIpv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Jul 2006 04:45:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G0wpF-0002v6-09
	for linux-ide@vger.kernel.org; Thu, 13 Jul 2006 10:45:37 +0200
Received: from duvalix.irisa.fr ([131.254.12.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Jul 2006 10:45:36 +0200
Received: from fbourget by duvalix.irisa.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Jul 2006 10:45:36 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Tejun Heo <htejun <at> gmail.com> writes:
> > 
> > First of all, try noop elevator.
> > ...
> 
> And one more thing, if a 67MB~4GB SDD drive speeds up the computation, 
> something is wrong.  4GB main memory will be much better than 4GB SDD 
> for such purposes.
> 



Thank you, we will try that !

(And you are right, that is a 67GB SSD ;)

