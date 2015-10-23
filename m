From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 23 Oct 2015 14:30:12 -0700
Message-ID: <CAJiQ=7A6L1m3nd4UfU_EYE+LGi0mz6Jq9yy6xkfnOvJBSmsL6A@mail.gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <20151023035817.GA18907@mtj.duckdns.org> <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
 <20151023203511.GN13239@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023203511.GN13239-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Oct 23, 2015 at 1:35 PM, Brian Norris
<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Oct 22, 2015 at 09:51:30PM -0700, Florian Fainelli wrote:
>> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>> I think we have a bit too many compatible strings defined, I need to
>> lookup tomorrow when I am back in the office which BCM7xxx started
>> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
>> sure
>
> I thought it was BCM7425, but you probably have the resources to check
> better than I do.

It was originally introduced on 7422 A0 (40nm) and the test chip that
preceded it.  The production rev of 7422 uses the 7425 die, so
"BCM7425" is a good enough answer for our purposes.

BCM7420, BCM7400, and other 65nm SoCs had a ServerWorks SATA2 core on
an internal PCI-X bus.  These ran a modified version of sata_svw.c,
and could support QDMA.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
