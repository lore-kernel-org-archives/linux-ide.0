From: Tejun Heo <tj@kernel.org>
Subject: Re: softreset
Date: Fri, 17 Jul 2009 12:58:04 +0900
Message-ID: <4A5FF6CC.6080003@kernel.org>
References: <93b143da0907090023w7eaa94c8gcaef9fa1771d3137@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36740 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757613AbZGQD6J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Jul 2009 23:58:09 -0400
In-Reply-To: <93b143da0907090023w7eaa94c8gcaef9fa1771d3137@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Porat <dan.porat@gmail.com>
Cc: linux-ide@vger.kernel.org

Dan Porat wrote:
> Hi all ,
> I am looking for a way to activate softreset through userspace command.
> Where is the closest place I have to place the hook for an Ioctl?
> 

echo - - - > /sys/class/scsi_host/hostX/scan

But you can't select between hard and soft resets.

-- 
tejun
