From: David Miller <davem@davemloft.net>
Subject: Re: v2: ide: Must hold queue lock when requeueing
Date: Thu, 01 Apr 2010 01:31:52 -0700 (PDT)
Message-ID: <20100401.013152.28774975.davem@davemloft.net>
References: <4BB40DD0.6050306@kernel.org>
	<20100401061159.GA21077@gondor.apana.org.au>
	<20100401061339.GA21145@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44547
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754217Ab0DAIbu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Apr 2010 04:31:50 -0400
In-Reply-To: <20100401061339.GA21145@gondor.apana.org.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: herbert@gondor.apana.org.au
Cc: tj@kernel.org, linux-ide@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 1 Apr 2010 14:13:39 +0800

> On Thu, Apr 01, 2010 at 02:11:59PM +0800, Herbert Xu wrote:
>> 
>> OK, here are the two patches again using ide_requeue_and_plug.
> 
> ide: Must hold queue lock when requeueing

Applied.
