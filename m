From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 12:50:51 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031008115051.GD705@redhat.com>
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk> <20031008151357.A31976@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6428 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261376AbTJHLvd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Oct 2003 07:51:33 -0400
Content-Disposition: inline
In-Reply-To: <20031008151357.A31976@in.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Oct 08, 2003 at 03:13:57PM +0530, Srivatsa Vaddagiri wrote:

 > /* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
 > /* ToDo : replace this routine based on loops_per_jiffy?? */
 > static inline void dump_udelay(unsigned int num_usec)
 > {
 > 	volatile unsigned int i;
 > 	for (i = 0; i < 10000 * num_usec; i++);
 > }

Why not just use udelay() ?  The above code cannot possibly do
the right thing on all processors.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
