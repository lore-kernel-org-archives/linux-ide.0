From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Fri, 09 Nov 2007 13:00:36 +0900
Message-ID: <4733DB64.1090803@gmail.com>
References: <41622.41856.qm@web52604.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:20798 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbXKIEAw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Nov 2007 23:00:52 -0500
Received: by rv-out-0910.google.com with SMTP id k20so356722rvb
        for <linux-ide@vger.kernel.org>; Thu, 08 Nov 2007 20:00:51 -0800 (PST)
In-Reply-To: <41622.41856.qm@web52604.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org

Srihari Vijayaraghavan wrote:
> (Same symptoms/behaviour as before: http://marc.info/?l=linux-ide&m=117949823328798&w=2  & http://marc.info/?t=117810970400003&r=1&w=2)
> 
> With mem=3500M all is well, otherwise it goes on reseting the ports in a loop & not booting :-(

Hmmm.. weird.  The workaround is still there.  Please post boot log.

Thanks.

-- 
tejun
