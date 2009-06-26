From: Tejun Heo <tj@kernel.org>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Fri, 26 Jun 2009 11:33:10 +0900
Message-ID: <4A443366.4010807@kernel.org>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org> <4A36FC7D.5050805@hadiko.de> <4A388E1F.5070404@kernel.org> <4A3FD015.4090602@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60377 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbZFZCdO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jun 2009 22:33:14 -0400
In-Reply-To: <4A3FD015.4090602@hadiko.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Jackowski <aXe@hadiko.de>
Cc: linux-ide@vger.kernel.org

Thomas Jackowski wrote:
> Hi,
> 
> I have no clue where this command comes from. How can I determine this?
> 
> I'm not using disk head parking.

Hmmm.... busy looping fuser -v /dev/sdX would probably catch it given
enough time.  Can you please run "while true; do fuser -v /dev/sdX;
done" for a while and report the result?  If it doesn't give you
anything, please let me know, I'll prep a debug patch.

Thanks.

-- 
tejun
