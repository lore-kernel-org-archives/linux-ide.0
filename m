From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Poll-based IDE driver
Date: Wed, 8 Oct 2003 17:48:51 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031008164851.GT29736@redhat.com>
References: <20031008115051.GD705@redhat.com> <Pine.LNX.4.10.10310080935350.7858-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13412 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S261592AbTJHQtg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Oct 2003 12:49:36 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10310080935350.7858-100000@master.linux-ide.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkcd-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Wed, Oct 08, 2003 at 09:36:36AM -0700, Andre Hedrick wrote:
 > 
 > Does not matter, priority is to get content to platter and the hell with
 > everything else.

I don't buy this. Without correct udelay()'s, how is code like this..

        for (i = 0; i < 10; i++) {
                dump_udelay(1);
                if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
                        return 0;
        } 

expected to work ? It won't wait for 10usec at all, but be over almost instantly.
Ramming commands at the drive before its status has settled doesn't strike
me as a particularly safe thing to do.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
