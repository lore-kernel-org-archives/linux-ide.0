From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH upstream-fixes] libata: unlock HPA if device shrunk
Date: Wed, 07 Apr 2010 06:05:13 +0900
Message-ID: <4BBBA209.1090405@kernel.org>
References: <4BB93DD9.7030909@kernel.org> <4BBB4BC5.5070200@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44711 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620Ab0DFVCG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Apr 2010 17:02:06 -0400
In-Reply-To: <4BBB4BC5.5070200@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, yaa.bta@gmail.com

On 04/06/2010 11:57 PM, Jeff Garzik wrote:
> patch is bigger than I would like for #upstream-fixes... but nothing to
> be done about that...  applied, thanks

Yeap, thought about splitting it but I couldn't decide whether that
was a good idea or not.  Thanks. :-)

-- 
tejun
