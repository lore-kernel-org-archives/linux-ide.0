From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 12:14:36 +0000
Message-ID: <20140219121436.GE10504@lee--X1>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <53049B7A.6080404@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50841 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaBSMOm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Feb 2014 07:14:42 -0500
Received: by mail-wi0-f174.google.com with SMTP id f8so4588057wiw.13
        for <linux-ide@vger.kernel.org>; Wed, 19 Feb 2014 04:14:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <53049B7A.6080404@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org

> >> Cc: Tejun Heo <tj@kernel.org>
> >> Cc: linux-ide@vger.kernel.org
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Please consider basing it on top of Hans' refactored ahci_platform.
> >=20
> >  http://www.spinics.net/lists/linux-ide/msg47628.html
>=20
> Which reminds I must test the version I've rebased on top of 3.14-rc1
> and then send a v6 so that this can get merged.
>=20
> Lee, I'll add you to the CC of the v6 I'm about to send.

Thanks Hans.

Once Tejun has accepted this driver I will go ahead and rebase on top
of your work and convert to the new API.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
