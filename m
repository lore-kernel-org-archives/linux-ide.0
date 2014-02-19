From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 08:30:25 +0000
Message-ID: <20140219083025.GB10504@lee--X1>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140218233645.GP31892@mtj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org, hdegoede@redhat.com
List-Id: linux-ide@vger.kernel.org

> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: linux-ide@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> Please consider basing it on top of Hans' refactored ahci_platform.
>=20
>  http://www.spinics.net/lists/linux-ide/msg47628.html

Okay, looks reasonable. I'm happy to do the extra work.

Can I do this as a subsequent patch though? The current patch fits
neatly onto our internal stable kernel (currently v3.10). The added
work will require back-porting Hans' patch-set, which has not yet
reached Mainline.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
