From: Alexander Gordeev <agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH libata/for-3.18-fixes] Revert "AHCI:
 Optimize single IRQ interrupt processing"
Date: Mon, 27 Oct 2014 16:05:47 +0000
Message-ID: <20141027160546.GB30198@agordeev.usersys.redhat.com>
References: <1414082970-20775-1-git-send-email-marc.zyngier@arm.com>
 <20141027132045.GA30198@agordeev.usersys.redhat.com>
 <20141027135802.GI4436@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDFPB5XX7IFBB5GWXGRAKGQEMS3JYTI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141027135802.GI4436-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
Content-Disposition: inline
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Mon, Oct 27, 2014 at 09:58:02AM -0400, Tejun Heo wrote:
> From 61e268068c92ed000f078dc1ab71d1228439fecd Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Date: Mon, 27 Oct 2014 09:50:36 -0400
> 
> This reverts commit 18dcf433f3ded61eb140a55e7048ec2fef79e723.
> IRQF_ONESHOT was missing from the conversion causing screaming
> interrupts problems on some setups and LKP detected measureable drop
> in IO performance.  It looks like we'll first need to drop the
> threaded IRQ handling first before splitting locking.

Tejun,

Sorry for missing to mention - I think it is better to revert 33fb0d0
("AHCI: Do not acquire ata_host::lock from single IRQ handler") first,
unless you examined it is fine to leave (I did not).

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
