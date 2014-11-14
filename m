From: Hans de Goede <jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
Date: Fri, 14 Nov 2014 03:56:21 -0800 (PST)
Message-ID: <037f97ce-468b-4b91-9616-51a3301c5be6@googlegroups.com>
References: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
 <20141113222952.GI2598@htj.dyndns.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_550_2032489366.1415966182001"
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBZW3S6RQKGQERVP2LHI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20141113222952.GI2598-Gd/HAXX7CRxy/B6EtB590w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

------=_Part_550_2032489366.1415966182001
Content-Type: text/plain; charset=UTF-8

Hi,

On Thursday, November 13, 2014 11:29:56 PM UTC+1, Tejun Heo wrote:
>
> On Thu, Nov 13, 2014 at 11:24:16AM +0100, Hans de Goede wrote: 
> > This is something which we inherited from the Allwinner android kernel 
> sources, 
> > and I've always wanted to test if this is really necessary. 
> > 
> > So recently I've bought a sata port multiplexer, and I've given this a 
> test 
> > spin on both A10 and A20 devices, and it seems to work fine: 
> > 
> > [    2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300) 
> > [    2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5 ports, 
> feat 0x5/0xf 
> > [    2.175511] ata1.00: hard resetting link 
> > [    2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320) 
> > [    2.531430] ata1.01: hard resetting link 
> > [    2.974465] ata1.01: link resume succeeded after 1 retries 
> > [    3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300) 
> > [    3.101431] ata1.02: hard resetting link 
> > [    4.174466] ata1.02: failed to resume link (SControl 0) 
> > [    4.180065] ata1.02: SATA link down (SStatus 0 SControl 0) 
> > (and the same for links 3 and 4) 
> > 
> > Once the NO_PMP flag is removed it correctly sees the 2 disks which I've 
> > attached, and I can mount and use them just fine, so lets drop the flag. 
> > 
> > Signed-off-by: Hans de Goede <hdeg...-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org <javascript:>> 
>
> Applied to libata/for-3.18-fixes. 
>

I just found out why Allwinner added that AHCI_HFLAG_NO_PMP flag, after 
putting the system I used to test the port multiplexer back together this 
morning, it seems that probing for a port multiplexer being present breaks 
the no-port-multiplexer (so direct attached disk) case :(  I guess I should 
have tested for that before sending the patch, but the thought of it 
breaking normal usage did not cross my mind.

So self NACK. If it is not too late, can you please drop this from your 
tree ?

Let me know if you want me to send a revert instead.

I'll look into fixing this another way, maybe with a quirk + an extra reset 
after failed pmp testing, and it that does not work a module option.

Thanks & Regards,

Hans

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

------=_Part_550_2032489366.1415966182001
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>On Thursday, November 13, 2014 11:29:56 PM UTC+=
1, Tejun Heo wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;mar=
gin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On Thu, Nov=
 13, 2014 at 11:24:16AM +0100, Hans de Goede wrote:
<br>&gt; This is something which we inherited from the Allwinner android ke=
rnel sources,
<br>&gt; and I've always wanted to test if this is really necessary.
<br>&gt;=20
<br>&gt; So recently I've bought a sata port multiplexer, and I've given th=
is a test
<br>&gt; spin on both A10 and A20 devices, and it seems to work fine:
<br>&gt;=20
<br>&gt; [ &nbsp; &nbsp;2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 =
SControl 300)
<br>&gt; [ &nbsp; &nbsp;2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x03=
25 r0, 5 ports, feat 0x5/0xf
<br>&gt; [ &nbsp; &nbsp;2.175511] ata1.00: hard resetting link
<br>&gt; [ &nbsp; &nbsp;2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 1=
23 SControl 320)
<br>&gt; [ &nbsp; &nbsp;2.531430] ata1.01: hard resetting link
<br>&gt; [ &nbsp; &nbsp;2.974465] ata1.01: link resume succeeded after 1 re=
tries
<br>&gt; [ &nbsp; &nbsp;3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 1=
23 SControl 300)
<br>&gt; [ &nbsp; &nbsp;3.101431] ata1.02: hard resetting link
<br>&gt; [ &nbsp; &nbsp;4.174466] ata1.02: failed to resume link (SControl =
0)
<br>&gt; [ &nbsp; &nbsp;4.180065] ata1.02: SATA link down (SStatus 0 SContr=
ol 0)
<br>&gt; (and the same for links 3 and 4)
<br>&gt;=20
<br>&gt; Once the NO_PMP flag is removed it correctly sees the 2 disks whic=
h I've
<br>&gt; attached, and I can mount and use them just fine, so lets drop the=
 flag.
<br>&gt;=20
<br>&gt; Signed-off-by: Hans de Goede &lt;<a href=3D"javascript:" target=3D=
"_blank" gdf-obfuscated-mailto=3D"1VeRR1GMlKcJ" onmousedown=3D"this.href=3D=
'javascript:';return true;" onclick=3D"this.href=3D'javascript:';return tru=
e;">hdeg...-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;
<br>
<br>Applied to libata/for-3.18-fixes.
<br></blockquote><br>I just found out why Allwinner added that AHCI_HFLAG_N=
O_PMP flag, after putting the system I used to test the port multiplexer ba=
ck together this morning, it seems that probing for a port multiplexer bein=
g present breaks the no-port-multiplexer (so direct attached disk) case :(&=
nbsp; I guess I should have tested for that before sending the patch, but t=
he thought of it breaking normal usage did not cross my mind.<br><br>So sel=
f NACK. If it is not too late, can you please drop this from your tree ?<br=
><br>Let me know if you want me to send a revert instead.<br><br>I'll look =
into fixing this another way, maybe with a quirk + an extra reset after fai=
led pmp testing, and it that does not work a module option.<br><br>Thanks &=
amp; Regards,<br><br>Hans<br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_550_2032489366.1415966182001--
