From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: icside.c: fix printk format string compile warning
Date: Wed, 06 Jun 2012 10:37:47 -0700 (PDT)
Message-ID: <20120606.103747.2047367637475518048.davem@davemloft.net>
References: <86hauw7jee.fsf_-_@gandalf.zerties.org>
	<1338672377.24148.6.camel@joe2Laptop>
	<86zk8i2b90.fsf@gandalf.zerties.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86zk8i2b90.fsf@gandalf.zerties.org>
Sender: linux-kernel-owner@vger.kernel.org
To: christian.dietrich@informatik.uni-erlangen.de
Cc: joe@perches.com, sshtylyov@mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de
List-Id: linux-ide@vger.kernel.org

From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Date: Tue, 05 Jun 2012 14:28:59 +0200

> Use correct format string parameter for the peak datarate, and prevent
> uninitialized use of cycle_time.
> 
> Signed-off-by: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>

Applied.
