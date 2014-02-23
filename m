From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 13/15] ARM: sun4i: dt: Remove grouping +
 simple-bus compatible for regulators
Date: Sun, 23 Feb 2014 09:03:48 +0100
Message-ID: <5309AB64.7010603@redhat.com>
References: <1393084424-31099-1-git-send-email-hdegoede@redhat.com> <1393084424-31099-14-git-send-email-hdegoede@redhat.com> <20140222214421.GC3610@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB36WU2MAKGQE3H5ILDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140222214421.GC3610@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/22/2014 10:44 PM, Maxime Ripard wrote:
> Hi,
> 
> On Sat, Feb 22, 2014 at 04:53:42PM +0100, Hans de Goede wrote:
>> According to Documentation/devicetree/bindings/regulator/regulator.txt regulator nodes should not be placed under 'simple-bus'.
>> 
>> Mark Rutland also explains about it at: http://www.spinics.net/lists/linux-usb/msg101497.html
>> 
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Applied in my sunxi/dt-for-3.15 branch.

Thanks, I assume this only applies to this patch, since we were still
discussing the common regulator bits of the ahci enablement dts patches ?

I'm not seeing any of your recent merges here:
https://github.com/mripard/linux/commits/sunxi/dt-for-3.15

Did you not push them, or am I looking at the wrong tree ?

Regards,

Hans

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMJq18ACgkQF3VEtJrzE/vngACfbYd5K2ZixBm45Y+e3cMFSq9M
v68Anjze6R6meI1Z5R0l4nFCNS8txl9p
=0XGo
-----END PGP SIGNATURE-----
