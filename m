From: Tejun Heo <tj@kernel.org>
Subject: Re: MWDMA Issue: sda: unknown partition table
Date: Sat, 22 Jan 2011 12:45:59 +0100
Message-ID: <20110122114559.GA6160@htj.dyndns.org>
References: <4D395B74.1010705@st.com>
 <20110121101400.GC2832@htj.dyndns.org>
 <4D395FE8.8000902@st.com>
 <4D39752B.7000202@st.com>
 <20110121163906.GG2832@htj.dyndns.org>
 <AANLkTimD0oDCx=UTYsenTNPgO4RgHGCKxrNyQ2u7atmE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32937 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab1AVLqG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jan 2011 06:46:06 -0500
Received: by fxm20 with SMTP id 20so2627986fxm.19
        for <linux-ide@vger.kernel.org>; Sat, 22 Jan 2011 03:46:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimD0oDCx=UTYsenTNPgO4RgHGCKxrNyQ2u7atmE@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.nitj@gmail.com>
Cc: viresh kumar <viresh.kumar@st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, amitgoel <amit.goel@st.com>

Hello,

On Sat, Jan 22, 2011 at 09:38:46AM +0530, Viresh Kumar wrote:
> As soon as handshaking is done, a read request of 4096 bytes is given:
> Here in both cases (PIO and MWDMA) first block of 512 bytes contained
> non-zero data but the other 7 blocks contained 0.

Hmmm, okay.  Well, I'm afraid you'll have to find out where things are
going wrong.  fs/partitions/check.h::read_part_sector() is the read
function used by partition check code.  You'll have to find where the
difference between what that code and your drive sees comes from.
Playing with dd in userland on the device node and see how reads and
writes behave would be helpful too.

> Also Arasan Controller, as far i have understood, doesn't transfer data directly
> to a memory location. Instead we need to read data from Controllers FIFO.
> So, probably it wouldn't be cache issue, as ARM is reading data directly from
> FIFO to our buffer (using its virtual address).

I don't really follow.  It's DMA.  The controller is writing to
memory.

Thanks.

-- 
tejun
