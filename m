From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Wed, 17 Jun 2009 15:33:03 +0900
Message-ID: <4A388E1F.5070404@kernel.org>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org> <4A36FC7D.5050805@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38195 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835AbZFQGdb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Jun 2009 02:33:31 -0400
In-Reply-To: <4A36FC7D.5050805@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

Hello,

Thomas Jackowski wrote:
> I'm using 2.6.29-2-amd64 now and the bug still exists (see previous
> mails) with AHCI and NCQ enabled.
> 
> Maybe I should contact Seagate Support now?
> 
> I wonder that nobody else reported this sort of problem?

There were several reports drives timing out some SMART commansd but
on CPM I think yours is the only one.  BTW, where is that command
coming from?  Are you using disk head parking?

Thanks.

-- 
tejun
