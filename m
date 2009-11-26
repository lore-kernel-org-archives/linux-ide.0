From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's EP93xx
	CPUs
Date: Thu, 26 Nov 2009 22:15:50 +0000
Message-ID: <4B0EFE16.6020808@inov.pt>
References: <200911261651.40928.bzolnier@gmail.com>
	<4B0EDAF9.7080902@bluewatersys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0958657270=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4B0EDAF9.7080902@bluewatersys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ryan Mallon <ryan@bluewatersys.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sergei Shtylyov <sshtylyov@ru.montavista.com>
List-Id: linux-ide@vger.kernel.org

--===============0958657270==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Ryan Mallon escreveu:
<blockquote cite="mid:4B0EDAF9.7080902@bluewatersys.com" type="cite">
  <pre wrap="">Bartlomiej Zolnierkiewicz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Based on the older IDE host driver by Joao Ramos and review comments
for it from Sergei Shtylyov.  Not yet tested with the real hardware.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <pre wrap="">Sidenote:

I have neither the hardware nor much personal interest in adding support
for it so I did it mainly cause:

- IDE host driver wasn't merged due to policy change and I hate seeing fair
  amount of review work from me &amp; Sergei going into waste. :)

- I was curious about some claims I've been hearing recently so I decided to
  verify them in practice (porting the driver to libata was relatively easy
  but unfortunately in the process it gained almost 50% in the LOC count..).

so if somebody would like to take over this patch feel free to do it.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Thanks for doing this. I'll see if I can dig out a hard-drive and give
this a test. I had some comments, but I will fix them up myself if I get
round to testing this.

~Ryan

  </pre>
</blockquote>
<font face="Calibri"><br>
Hi,<br>
<br>
Thanks for pushing this one up to the kernel and Bart, for the
extensive rework made to support libata.<br>
<br>
Unfornately, since the last patch I send for approval, I haven't had
much time to continue this work; as a matter of fact, the work I was
developing with the EP9315 processor is done, and I am no longer
working on it (for now, I suppose), so I hadn't much time to work on
this and to further improve the patch for submission; so I must thank
Bart for giving this patch another try and finishing it.<br>
The important thing is that it didn't get lost in the middle and the
EP93xx users can use this functionallity in their EP93xx-based boards.<br>
<br>
If I have an opportunity, I will try to check if everything is ok (I'll
have to dig up my EDB9315A board somewhere in the old project's box :) )<br>
<br>
Once again, thanks for finishing this patch.<br>
<br>
Joao Ramos<br>
</font><br>
</body>
</html>


--===============0958657270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0958657270==--
