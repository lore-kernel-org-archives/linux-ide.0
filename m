From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ide-core.o & libata.o ICH5
Date: Wed, 22 Dec 2004 15:14:34 -0500
Message-ID: <41C9D5AA.70804@pobox.com>
References: <41C341A4.9010401@Verizon.Net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10422 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262031AbULVUOn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Dec 2004 15:14:43 -0500
In-Reply-To: <41C341A4.9010401@Verizon.Net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Cc: linux-ide@vger.kernel.org

You need (a) 2.4.29-pre2 and (b) to build IDE into the kernel, not as a 
module.

Also, when posting oopses, they are useless unless you run them through 
ksymoops.

	Jeff


