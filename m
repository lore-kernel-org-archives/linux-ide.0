From: Jeff Garzik <jeff@garzik.org>
Subject: Re: correct kernel parameter in documentation.
Date: Sat, 29 Sep 2007 02:23:29 -0400
Message-ID: <46FDEF61.40002@garzik.org>
References: <20070927155013.GA20219@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33947 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755137AbXI2GXb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 02:23:31 -0400
In-Reply-To: <20070927155013.GA20219@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Jeff Garzik <jeff@garzik.org>

Dave Jones wrote:
> 'noacpi' isn't a standalone parameter, give it its prefix.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>

applied

(though in general we should not list module parameters here, I am OK 
with this one)


