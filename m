Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2E1C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 14 Nov 2022 20:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiKNUwX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiKNUwW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 14 Nov 2022 15:52:22 -0500
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11BA175AF
        for <linux-ide@vger.kernel.org>; Mon, 14 Nov 2022 12:52:18 -0800 (PST)
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
        c=relaxed/relaxed; q=dns/txt; h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References;
        bh=LUAgS+S1RiaThhatk7195jTcf4UVbXr1HJGBIokf+ag=;
        b=gJ64QQJLFZ6GoxvzfvAEdjxuM9Uegtehv3VbI6NqoJqEYcaKzLu72ZWwDBQLvI/Ioes+sNwISGtc28RCsFdWuHV4vPwN4lzjdiCKmncH4VJGy/7rpLJjxwWfbwLGRbxcb51Ew5nm2ZDNEWT61UtHGbeohUnqWPK3bL9UxMUXhBMYLbf1CoQHJgUYWom6ufvYcgSeXWP+TytMdOrGi6+gtPmqGDZKiVQadXOWWBDQvIHObznXakIboTgzOo
        SuMenz1q3Se+ZQm1JBV/G7GzIInd2Rf8ZUEr5yvtZlsRQ9ck9wlBVeAf0Ks0VSK7bZksXsTcuVaW8BT/yZWU8+eP1gvA==
Received: from webmail.dynu.com (webmail.dynu.com [162.216.242.204])
        by mx1.wiredblade.com with ESMTPA
        ; Mon, 14 Nov 2022 20:52:17 +0000
MIME-Version: 1.0
Date:   Mon, 14 Nov 2022 20:52:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.16.0
From:   marius@psihoexpert.ro
Message-ID: <29aff79be06b7dacb97c13cbff07fabb@psihoexpert.ro>
Subject: Re: Bug report for ahci-mvebu driver
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
In-Reply-To: <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
References: <dc9f74bd-91d7-cda1-8182-11d400e6bc3f@opensource.wdc.com>
 <a1b3b74b-1548-44d9-7d72-8eb428fa1788@opensource.wdc.com>
 <0ba8ebf7-6e6c-e63d-32c4-44d97898be1d@opensource.wdc.com>
 <126ce7f2-3de2-9e75-7920-09d78c224d76@opensource.wdc.com>
 <ABCCF36A7F484055A8E63A8B739DC7B8@graph>
 <3c94c10243fa1cd2b0128db846298a11@psihoexpert.ro>
 <13f7138c46c4c486a29322baa4cc414b@psihoexpert.ro>
 <40f4ae2000164863253c67d405e4f875@psihoexpert.ro>
X-Originating-IP: 86.122.18.201
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

November 12, 2022 3:57 AM, "Damien Le Moal" <damien.lemoal@opensource.wdc=
.com> wrote:

> Given that I do not have access to the hardware, I cannot do much. Try =
to
> see if adding error messages in sata_link_hardreset() for anything that
> fails in that function can help. This may give some hints.
>=20
>=20--
> Damien Le Moal
> Western Digital Research

It seems that sata_link_hardreset() fails in more than one way:

---- CABLE CONNECTED ----
[   32.192282][  T104] Online=3D>Offline       <--- sata_link_hardreset()=
, inside "if(online)"
[   32.196848][  T104] do loop               <--- sata_link_resume(), ins=
ide the do{} loop, at the beginning
[   32.420858][  T104] post-do checkpoint    <--- sata_link_resume(), aft=
er do/while condition
[   32.423662][  T104] debounce start loop   <--- sata_link_debounce(), j=
ust before while(1)
[   32.470858][  T104] debounce SCR: 0x100   <--- sata_link_debounce(), a=
fter sata_scr_read(), prints "cur" value
[   32.530857][  T104] debounce SCR: 0x100
[   32.590857][  T104] debounce SCR: 0x100
[   32.650857][  T104] debounce SCR: 0x100
[   32.710857][  T104] debounce SCR: 0x100
[   32.770857][  T104] debounce SCR: 0x100
[   32.830857][  T104] debounce SCR: 0x100
[   32.890857][  T104] debounce SCR: 0x100
[   32.950857][  T104] debounce SCR: 0x101
[   33.010857][  T104] debounce SCR: 0x100
[   33.070857][  T104] debounce SCR: 0x100
[   33.130857][  T104] debounce SCR: 0x100
[   33.190857][  T104] debounce SCR: 0x100
[   33.250857][  T104] debounce SCR: 0x100
[   33.310857][  T104] debounce SCR: 0x100
[   33.360857][  T104] debounce SCR: 0x101
[   33.420857][  T104] debounce SCR: 0x100
[   33.470857][  T104] debounce SCR: 0x100
[   33.530857][  T104] debounce SCR: 0x100
[   33.580857][  T104] debounce SCR: 0x100
[   33.630857][  T104] debounce SCR: 0x101
[   33.680857][  T104] debounce SCR: 0x100
[   33.730857][  T104] debounce SCR: 0x100
[   33.790857][  T104] debounce SCR: 0x100
[   33.850857][  T104] debounce SCR: 0x100
[   33.910857][  T104] debounce SCR: 0x101
[   33.970857][  T104] debounce SCR: 0x0
[   34.020857][  T104] debounce SCR: 0x0
[   34.080857][  T104] debounce SCR: 0x0
[   34.130857][  T104] debounce SCR: 0x0
[   34.190857][  T104] debounce SCR: 0x100
[   34.250857][  T104] debounce SCR: 0x100
[   34.310857][  T104] debounce SCR: 0x100
[   34.360857][  T104] debounce SCR: 0x100
[   34.420857][  T104] debounce SCR: 0x100
[   34.480857][  T104] debounce SCR: 0x100
[   34.484707][  T104] final checkpoint            <--- sata_link_resume(=
), just before final return
[   34.488557][  T104] Link offline after resume   <--- sata_link_hardres=
et(), at the ata_phys_link_offline(link) condition
[   34.496525][  T104] ata2: SATA link down (SStatus 100 SControl 300)
[   34.502833][  T104] Online=3D>Offline
[   34.507390][  T104] do loop
[   34.720857][  T104] post-do checkpoint
[   34.723661][  T104] debounce start loop
[   34.780857][  T104] debounce SCR: 0x100
[   34.840857][  T104] debounce SCR: 0x100
[   34.890857][  T104] debounce SCR: 0x100
[   34.950857][  T104] debounce SCR: 0x100
[   35.010857][  T104] debounce SCR: 0x100
[   35.060857][  T104] debounce SCR: 0x100
[   35.120857][  T104] debounce SCR: 0x100
[   35.180857][  T104] debounce SCR: 0x101
[   35.230857][  T104] debounce SCR: 0x100
[   35.290857][  T104] debounce SCR: 0x100
[   35.350857][  T104] debounce SCR: 0x100
[   35.410857][  T104] debounce SCR: 0x100
[   35.460857][  T104] debounce SCR: 0x101
[   35.510857][  T104] debounce SCR: 0x100
[   35.570857][  T104] debounce SCR: 0x100
[   35.630857][  T104] debounce SCR: 0x100
[   35.690857][  T104] debounce SCR: 0x100
[   35.750857][  T104] debounce SCR: 0x101
[   35.810857][  T104] debounce SCR: 0x100
[   35.870857][  T104] debounce SCR: 0x101
[   35.920857][  T104] debounce SCR: 0x100
[   35.980857][  T104] debounce SCR: 0x101
[   36.030857][  T104] debounce SCR: 0x100
[   36.090857][  T104] debounce SCR: 0x100
[   36.150857][  T104] debounce SCR: 0x100
[   36.200857][  T104] debounce SCR: 0x100
[   36.260857][  T104] debounce SCR: 0x101
[   36.310857][  T104] debounce SCR: 0x100
[   36.360857][  T104] debounce SCR: 0x100
[   36.420857][  T104] debounce SCR: 0x100
[   36.480857][  T104] debounce SCR: 0x100
[   36.540857][  T104] debounce SCR: 0x100
[   36.600857][  T104] debounce SCR: 0x100
[   36.660857][  T104] debounce SCR: 0x101
[   36.720857][  T104] debounce SCR: 0x100
[   36.780857][  T104] debounce SCR: 0x100
[   36.840857][  T104] debounce SCR: 0x100
[   36.890857][  T104] debounce SCR: 0x100
[   36.950857][  T104] debounce SCR: 0x100
[   37.010857][  T104] debounce SCR: 0x100
[   37.070857][  T104] debounce SCR: 0x100
[   37.130857][  T104] debounce SCR: 0x100
[   37.190857][  T104] debounce SCR: 0x100
[   37.250857][  T104] debounce SCR: 0x100
[   37.254707][  T104] final checkpoint
[   37.258556][  T104] Link offline after resume
[   37.266522][  T104] ata2: SATA link down (SStatus 100 SControl 300)
[   37.272827][  T104] Online=3D>Offline
[   37.277384][  T104] do loop
[   37.500857][  T104] post-do checkpoint
[   37.503661][  T104] debounce start loop
[   37.550857][  T104] debounce SCR: 0x101
[   37.610857][  T104] debounce SCR: 0x100
[   37.670857][  T104] debounce SCR: 0x100
[   37.730857][  T104] debounce SCR: 0x100
[   37.780857][  T104] debounce SCR: 0x100
[   37.840857][  T104] debounce SCR: 0x101
[   37.900857][  T104] debounce SCR: 0x100
[   37.950857][  T104] debounce SCR: 0x100
[   38.000857][  T104] debounce SCR: 0x100
[   38.050857][  T104] debounce SCR: 0x100
[   38.110857][  T104] debounce SCR: 0x100
[   38.170857][  T104] debounce SCR: 0x100
[   38.230857][  T104] debounce SCR: 0x100
[   38.290857][  T104] debounce SCR: 0x100
[   38.340857][  T104] debounce SCR: 0x100
[   38.400857][  T104] debounce SCR: 0x101
[   38.460857][  T104] debounce SCR: 0x100
[   38.510857][  T104] debounce SCR: 0x100
[   38.570857][  T104] debounce SCR: 0x0
[   38.620857][  T104] debounce SCR: 0x0
[   38.670857][  T104] debounce SCR: 0x0
[   38.730857][  T104] debounce SCR: 0x0
[   38.790857][  T104] debounce SCR: 0x100
[   38.850857][  T104] debounce SCR: 0x101
[   38.910857][  T104] debounce SCR: 0x100
[   38.960857][  T104] debounce SCR: 0x100
[   39.020857][  T104] debounce SCR: 0x100
[   39.080857][  T104] debounce SCR: 0x100
[   39.140857][  T104] debounce SCR: 0x101
[   39.200857][  T104] debounce SCR: 0x100
[   39.260857][  T104] debounce SCR: 0x100
[   39.320857][  T104] debounce SCR: 0x100
[   39.380857][  T104] debounce SCR: 0x100
[   39.430857][  T104] debounce SCR: 0x101
[   39.490857][  T104] debounce SCR: 0x100
[   39.550857][  T104] debounce SCR: 0x100
[   39.610857][  T104] debounce SCR: 0x100
[   39.670857][  T104] debounce SCR: 0x100
[   39.730857][  T104] debounce SCR: 0x100
[   39.780857][  T104] debounce SCR: 0x100
[   39.840857][  T104] debounce SCR: 0x101
[   39.844707][  T104] debounce timeout!     <--- sata_link_debounce(), j=
ust before final "return -EPIPE;"
[   39.848556][  T104] debounce failed       <--- sata_link_resume(), in =
sata_link_debounce() check
[   39.852234][  T104] Failed resume         <--- sata_link_hardreset(), =
in sata_link_resume() check
[   39.859061][  T104] ata2: COMRESET failed (errno=3D-32)
[   39.864136][  T104] ata2: reset failed (errno=3D-32), retrying in 8 se=
cs
[   47.840858][  T104] Online=3D>Offline
[   47.845413][  T104] do loop
[   48.070857][  T104] post-do checkpoint
[   48.073661][  T104] debounce start loop
[   48.130857][  T104] debounce SCR: 0x100
[   48.180857][  T104] debounce SCR: 0x100
[   48.240857][  T104] debounce SCR: 0x100
[   48.300856][  T104] debounce SCR: 0x100
[   48.360857][  T104] debounce SCR: 0x100
[   48.410857][  T104] debounce SCR: 0x100
[   48.460857][  T104] debounce SCR: 0x101
[   48.520857][  T104] debounce SCR: 0x100
[   48.580857][  T104] debounce SCR: 0x101
[   48.640857][  T104] debounce SCR: 0x100
[   48.690857][  T104] debounce SCR: 0x100
[   48.740857][  T104] debounce SCR: 0x100
[   48.790857][  T104] debounce SCR: 0x100
[   48.850857][  T104] debounce SCR: 0x100
[   48.900857][  T104] debounce SCR: 0x100
[   48.960857][  T104] debounce SCR: 0x100
[   49.020857][  T104] debounce SCR: 0x100
[   49.070857][  T104] debounce SCR: 0x100
[   49.130857][  T104] debounce SCR: 0x101
[   49.190857][  T104] debounce SCR: 0x100
[   49.240857][  T104] debounce SCR: 0x100
[   49.290857][  T104] debounce SCR: 0x100
[   49.350857][  T104] debounce SCR: 0x100
[   49.400857][  T104] debounce SCR: 0x100
[   49.450857][  T104] debounce SCR: 0x100
[   49.510857][  T104] debounce SCR: 0x100
[   49.560857][  T104] debounce SCR: 0x100
[   49.620857][  T104] debounce SCR: 0x100
[   49.680857][  T104] debounce SCR: 0x101
[   49.740857][  T104] debounce SCR: 0x100
[   49.800857][  T104] debounce SCR: 0x100
[   49.850857][  T104] debounce SCR: 0x100
[   49.900857][  T104] debounce SCR: 0x100
[   49.960857][  T104] debounce SCR: 0x101
[   50.010857][  T104] debounce SCR: 0x100
[   50.070857][  T104] debounce SCR: 0x100
[   50.130857][  T104] debounce SCR: 0x100
[   50.190857][  T104] debounce SCR: 0x100
[   50.240857][  T104] debounce SCR: 0x101
[   50.244707][  T104] debounce timeout!
[   50.248556][  T104] debounce failed
[   50.252234][  T104] Failed resume
[   50.259059][  T104] ata2: COMRESET failed (errno=3D-32)
[   50.264133][  T104] ata2: reset failed (errno=3D-32), retrying in 8 se=
cs
[   58.080858][  T104] Online=3D>Offline
[   58.085413][  T104] do loop
[   58.310857][  T104] post-do checkpoint
[   58.313660][  T104] debounce start loop
[   58.370857][  T104] debounce SCR: 0x101
[   58.430857][  T104] debounce SCR: 0x100
[   58.480857][  T104] debounce SCR: 0x100
[   58.540857][  T104] debounce SCR: 0x100
[   58.600857][  T104] debounce SCR: 0x100
[   58.660857][  T104] debounce SCR: 0x100
[   58.720857][  T104] debounce SCR: 0x100
[   58.770857][  T104] debounce SCR: 0x100
[   58.820857][  T104] debounce SCR: 0x100
[   58.880857][  T104] debounce SCR: 0x100
[   58.940857][  T104] debounce SCR: 0x100
[   58.944707][  T104] final checkpoint
[   58.948556][  T104] Link offline after resume
[   58.956521][  T104] ata2: SATA link down (SStatus 101 SControl 300)
[   58.962825][  T104] Online=3D>Offline
[   58.967381][  T104] do loop
[   59.190857][  T104] post-do checkpoint
[   59.193662][  T104] debounce start loop
[   59.250857][  T104] debounce SCR: 0x100
[   59.310857][  T104] debounce SCR: 0x100
[   59.370857][  T104] debounce SCR: 0x100
[   59.430857][  T104] debounce SCR: 0x100
[   59.480857][  T104] debounce SCR: 0x100
[   59.540857][  T104] debounce SCR: 0x101
[   59.600857][  T104] debounce SCR: 0x100
[   59.660857][  T104] debounce SCR: 0x100
[   59.720857][  T104] debounce SCR: 0x100
[   59.780857][  T104] debounce SCR: 0x100
[   59.840857][  T104] debounce SCR: 0x100
[   59.900857][  T104] debounce SCR: 0x100
[   59.950857][  T104] debounce SCR: 0x100
[   60.010857][  T104] debounce SCR: 0x100
[   60.070857][  T104] debounce SCR: 0x100
[   60.120857][  T104] debounce SCR: 0x100
[   60.124707][  T104] final checkpoint
[   60.128556][  T104] Link offline after resume
[   60.136521][  T104] ata2: SATA link down (SStatus 101 SControl 300)
[   60.142825][  T104] Online=3D>Offline
[   60.147380][  T104] do loop
[   60.370857][  T104] post-do checkpoint
[   60.373661][  T104] debounce start loop
[   60.430857][  T104] debounce SCR: 0x100
[   60.490857][  T104] debounce SCR: 0x100
[   60.540857][  T104] debounce SCR: 0x101
[   60.600857][  T104] debounce SCR: 0x100
[   60.660857][  T104] debounce SCR: 0x100
[   60.720857][  T104] debounce SCR: 0x101
[   60.780857][  T104] debounce SCR: 0x100
[   60.830857][  T104] debounce SCR: 0x100
[   60.890857][  T104] debounce SCR: 0x100
[   60.950857][  T104] debounce SCR: 0x100
[   61.000857][  T104] debounce SCR: 0x100
[   61.060857][  T104] debounce SCR: 0x100
[   61.120857][  T104] debounce SCR: 0x101
[   61.170857][  T104] debounce SCR: 0x100
[   61.230857][  T104] debounce SCR: 0x100
[   61.290857][  T104] debounce SCR: 0x100
[   61.350857][  T104] debounce SCR: 0x100
[   61.410857][  T104] debounce SCR: 0x100
[   61.470857][  T104] debounce SCR: 0x100
[   61.530857][  T104] debounce SCR: 0x100
[   61.590857][  T104] debounce SCR: 0x0
[   61.650857][  T104] debounce SCR: 0x0
[   61.700857][  T104] debounce SCR: 0x0
[   61.704532][  T104] final checkpoint
[   61.708207][  T104] Link offline after resume
[   61.716172][  T104] ata2: SATA link down (SStatus 0 SControl 300)
[   61.771780][  T104] Online=3D>Offline
[   61.776336][  T104] do loop
[   62.000857][  T104] post-do checkpoint
[   62.003660][  T104] debounce start loop
[   62.050857][  T104] debounce SCR: 0x100
[   62.110857][  T104] debounce SCR: 0x100
[   62.170857][  T104] debounce SCR: 0x100
[   62.230857][  T104] debounce SCR: 0x101
[   62.290857][  T104] debounce SCR: 0x100
[   62.350857][  T104] debounce SCR: 0x101
[   62.410857][  T104] debounce SCR: 0x100
[   62.470857][  T104] debounce SCR: 0x101
[   62.520857][  T104] debounce SCR: 0x100
[   62.580857][  T104] debounce SCR: 0x100
[   62.630857][  T104] debounce SCR: 0x100
[   62.690857][  T104] debounce SCR: 0x100
[   62.750857][  T104] debounce SCR: 0x101
[   62.810857][  T104] debounce SCR: 0x100
[   62.860857][  T104] debounce SCR: 0x100
[   62.910857][  T104] debounce SCR: 0x100
[   62.970857][  T104] debounce SCR: 0x100
[   63.030857][  T104] debounce SCR: 0x100
[   63.090857][  T104] debounce SCR: 0x100
[   63.150857][  T104] debounce SCR: 0x101
[   63.210857][  T104] debounce SCR: 0x100
[   63.270857][  T104] debounce SCR: 0x101
[   63.330857][  T104] debounce SCR: 0x100
[   63.390857][  T104] debounce SCR: 0x101
[   63.450857][  T104] debounce SCR: 0x100
[   63.510857][  T104] debounce SCR: 0x100
[   63.570857][  T104] debounce SCR: 0x100
[   63.620857][  T104] debounce SCR: 0x100
[   63.670857][  T104] debounce SCR: 0x100
[   63.730857][  T104] debounce SCR: 0x100
[   63.790857][  T104] debounce SCR: 0x100
[   63.850857][  T104] debounce SCR: 0x100
[   63.910857][  T104] debounce SCR: 0x100
[   63.970857][  T104] debounce SCR: 0x100
[   63.974707][  T104] final checkpoint
[   63.978556][  T104] Link offline after resume
[   63.986520][  T104] ata2: SATA link down (SStatus 100 SControl 300)
[   63.992823][  T104] Online=3D>Offline
[   63.997380][  T104] do loop
[   64.220857][  T104] post-do checkpoint
[   64.223662][  T104] debounce start loop
[   64.270857][  T104] debounce SCR: 0x100
[   64.330857][  T104] debounce SCR: 0x101
[   64.390857][  T104] debounce SCR: 0x100
[   64.440857][  T104] debounce SCR: 0x100
[   64.500857][  T104] debounce SCR: 0x101
[   64.550857][  T104] debounce SCR: 0x100
[   64.600857][  T104] debounce SCR: 0x100
[   64.660857][  T104] debounce SCR: 0x100
[   64.710857][  T104] debounce SCR: 0x100
[   64.770857][  T104] debounce SCR: 0x100
[   64.830857][  T104] debounce SCR: 0x100
[   64.890857][  T104] debounce SCR: 0x101
[   64.950857][  T104] debounce SCR: 0x100
[   65.010857][  T104] debounce SCR: 0x101
[   65.060857][  T104] debounce SCR: 0x100
[   65.120857][  T104] debounce SCR: 0x100
[   65.180857][  T104] debounce SCR: 0x100
[   65.240857][  T104] debounce SCR: 0x100
[   65.300857][  T104] debounce SCR: 0x100
[   65.360857][  T104] debounce SCR: 0x100
[   65.410857][  T104] debounce SCR: 0x101
[   65.470857][  T104] debounce SCR: 0x100
[   65.530857][  T104] debounce SCR: 0x100
[   65.590857][  T104] debounce SCR: 0x100
[   65.650857][  T104] debounce SCR: 0x100
[   65.700857][  T104] debounce SCR: 0x100
[   65.760857][  T104] debounce SCR: 0x100
[   65.810857][  T104] debounce SCR: 0x101
[   65.870857][  T104] debounce SCR: 0x100
[   65.930857][  T104] debounce SCR: 0x100
[   65.980857][  T104] debounce SCR: 0x100
[   66.040857][  T104] debounce SCR: 0x100
[   66.100857][  T104] debounce SCR: 0x100
[   66.160857][  T104] debounce SCR: 0x0
[   66.210857][  T104] debounce SCR: 0x0
[   66.270857][  T104] debounce SCR: 0x0
[   66.330857][  T104] debounce SCR: 0x0
[   66.390857][  T104] debounce SCR: 0x100
[=20=20=2066.394532][  T104] final checkpoint
[   66.398382][  T104] Link offline after resume
[   66.406345][  T104] ata2: SATA link down (SStatus 100 SControl 300)
[   66.412649][  T104] Online=3D>Offline
[   66.417204][  T104] do loop
[   66.630857][  T104] post-do checkpoint
[   66.633661][  T104] debounce start loop
[   66.680857][  T104] debounce SCR: 0x100
[   66.740857][  T104] debounce SCR: 0x100
[   66.800857][  T104] debounce SCR: 0x100
[   66.860857][  T104] debounce SCR: 0x100
[   66.920857][  T104] debounce SCR: 0x100
[   66.980857][  T104] debounce SCR: 0x101
[   67.040857][  T104] debounce SCR: 0x100
[   67.100857][  T104] debounce SCR: 0x100
[   67.160857][  T104] debounce SCR: 0x100
[   67.220857][  T104] debounce SCR: 0x100
[   67.280857][  T104] debounce SCR: 0x100
[   67.330857][  T104] debounce SCR: 0x100
[   67.390857][  T104] debounce SCR: 0x101
[   67.450857][  T104] debounce SCR: 0x100
[   67.510857][  T104] debounce SCR: 0x100
[   67.570857][  T104] debounce SCR: 0x100
[   67.630857][  T104] debounce SCR: 0x100
[   67.690857][  T104] debounce SCR: 0x100
[   67.750857][  T104] debounce SCR: 0x100
[   67.810857][  T104] debounce SCR: 0x100
[   67.860857][  T104] debounce SCR: 0x100
[   67.920857][  T104] debounce SCR: 0x101
[   67.970857][  T104] debounce SCR: 0x100
[   68.030857][  T104] debounce SCR: 0x100
[   68.090857][  T104] debounce SCR: 0x100
[   68.150857][  T104] debounce SCR: 0x100
[   68.210857][  T104] debounce SCR: 0x101
[   68.260857][  T104] debounce SCR: 0x100
[   68.310857][  T104] debounce SCR: 0x100
[   68.370857][  T104] debounce SCR: 0x100
[   68.420857][  T104] debounce SCR: 0x100
[   68.480857][  T104] debounce SCR: 0x101
[   68.540857][  T104] debounce SCR: 0x100
[   68.600857][  T104] debounce SCR: 0x100
[   68.660857][  T104] debounce SCR: 0x100
[   68.720857][  T104] debounce SCR: 0x100
[   68.770857][  T104] debounce SCR: 0x100
[   68.820857][  T104] debounce SCR: 0x100
[   68.880857][  T104] debounce SCR: 0x100
[   68.940857][  T104] debounce SCR: 0x100
[   68.990857][  T104] debounce SCR: 0x101
[   68.994707][  T104] debounce timeout!
[   68.998556][  T104] debounce failed
[   69.002235][  T104] Failed resume
[   69.009062][  T104] ata2: COMRESET failed (errno=3D-32)
[   69.014136][  T104] ata2: reset failed (errno=3D-32), retrying in 8 se=
cs
---- CABLE DISCONNECT HERE ----
[   76.640858][  T104] Online=3D>Offline
[   76.645414][  T104] do loop
[   76.870857][  T104] post-do checkpoint
[   76.873661][  T104] debounce start loop
[   76.930857][  T104] debounce SCR: 0x0
[   76.990857][  T104] debounce SCR: 0x0
[   77.050857][  T104] debounce SCR: 0x0
[   77.100857][  T104] debounce SCR: 0x0
[   77.150857][  T104] debounce SCR: 0x0
[   77.200857][  T104] debounce SCR: 0x0
[   77.260857][  T104] debounce SCR: 0x0
[   77.310857][  T104] debounce SCR: 0x0
[   77.370857][  T104] debounce SCR: 0x0
[   77.420857][  T104] debounce SCR: 0x0
[   77.424532][  T104] final checkpoint
[   77.428207][  T104] Link offline after resume
[   77.436172][  T104] ata2: SATA link down (SStatus 0 SControl 300)

Marius Dinu

