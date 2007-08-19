From: Tejun Heo <htejun@gmail.com>
Subject: Re: Enabling AHCI on ICH7 without BIOS support
Date: Sun, 19 Aug 2007 17:07:18 +0900
Message-ID: <46C7FA36.4090504@gmail.com>
References: <46C1A999.5070109@dastyle.net>	<46C441CB.8020805@gmail.com>	<46C44A05.9040302@dastyle.net> <20070819014412.1378C5ED6F3@master.hanzubon.jp> <46C7D666.8020700@gmail.com> <loom.20070819T084305-257@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9566 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXHSIIg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Aug 2007 04:08:36 -0400
Received: by wa-out-1112.google.com with SMTP id j4so431517wah
        for <linux-ide@vger.kernel.org>; Sun, 19 Aug 2007 01:08:36 -0700 (PDT)
In-Reply-To: <loom.20070819T084305-257@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
Cc: linux-ide@vger.kernel.org

T=F6r=F6k Edwin wrote:
> If there is a document describing _exactly_ what steps I need to foll=
ow to
> properly enable the device, I'd be happy to read it, but I guess such
> documentation is only available to BIOS developers.

It all depends on how BIOS set up the controller / IO regions during
boot and even worse BIOS might expect certain configuration when ACPI
suspend/resume or shutdown transition is requested.  I don't really
think we can include AHCI force-enable in the mainline.  It's just too
risky without too much benefit.

--=20
tejun
