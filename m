From: Dan Fulger <danfulger@rdslink.ro>
Subject: Re: With a Barracuda harddisk as hda, Linux 2.6.14 and 2.6.15
  DON'T work, 2.6.11 WORKS
Date: Wed, 08 Mar 2006 00:45:48 +0200
Message-ID: <7.0.0.16.2.20060308004313.02ccac90@rdslink.ro>
References: <7.0.0.16.2.20060307204435.02cc49c0@pcnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.rdslink.ro ([193.231.236.97]:6619 "EHLO smtp.rdslink.ro")
	by vger.kernel.org with ESMTP id S964826AbWCGWls (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Mar 2006 17:41:48 -0500
In-Reply-To: <7.0.0.16.2.20060307204435.02cc49c0@pcnet.ro>
References: <7.0.0.16.2.20060307204435.02cc49c0@pcnet.ro>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

         I solved this with pci=usepirqmask. 

