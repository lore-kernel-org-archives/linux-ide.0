From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] ahci: st: Add support for ST's SATA IP
Date: Wed, 19 Feb 2014 15:01:21 +0000
Message-ID: <20140219150121.GG10504@lee--X1>
References: <1392641818-23419-1-git-send-email-lee.jones@linaro.org>
 <1392641818-23419-3-git-send-email-lee.jones@linaro.org>
 <20140218233645.GP31892@mtj.dyndns.org>
 <20140219083025.GB10504@lee--X1>
 <20140219140458.GA10134@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140219140458.GA10134@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alexandre.torgue@st.com, linux-ide@vger.kernel.org, hdegoede@redhat.com
List-Id: linux-ide@vger.kernel.org

> > Can I do this as a subsequent patch though? The current patch fits
> > neatly onto our internal stable kernel (currently v3.10). The added
> > work will require back-porting Hans' patch-set, which has not yet
> > reached Mainline.
>=20
> Hmm.... I'll apply Hans' patchset pretty soon and we still have some
> time in this devel cycle so I'd much prefer applying the final patch.

I think that's a pretty unfair ask. I could understand if the
patch(es) didn't apply, or were hindered by the new API change, but I
do not believe that is the case?

=46WIW, I have tried to apply the patches Hans send me, but they don't
seem to apply cleanly.

Base is v3.14-rc1:

Applying: ahci-platform: Add support for devices with more then 1 clock
fatal: sha1 information is lacking or useless (drivers/ata/ahci_platfor=
m.c).
Repository lacks necessary blobs to fall back on 3-way merge.
Cannot fall back to three-way merge.
Patch failed at 0001 ahci-platform: Add support for devices with more t=
hen 1 clock
The copy of the patch that failed is found in:
   .git/rebase-apply/patch
When you have resolved this problem, run "git am --resolved".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Any ideas?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
