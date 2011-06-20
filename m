From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and
 rename it
Date: Mon, 20 Jun 2011 14:47:38 +0200
Message-ID: <20110620124738.GO2611@htj.dyndns.org>
References: <20110617120704.GH2611@htj.dyndns.org>
 <1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
 <20110620081937.GN2611@htj.dyndns.org>
 <BANLkTi=dgTNUESCstJNFUg6_YLbfwpNF5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36925 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1FTMrn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2011 08:47:43 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=dgTNUESCstJNFUg6_YLbfwpNF5g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuan-Hsin Chen <yuanlmm@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>

Hello,

On Mon, Jun 20, 2011 at 06:06:52PM +0800, Yuan-Hsin Chen wrote:
> > Heh, I know I suggested that name but that is one ugly name. =A0If
> > anyone has any better idea, please come forward.
>=20
> How about ahci_pmp_workaround_softreset or ahci_pmp_ipms_set_softrese=
t?
> Also applys to ops, ahci_pmp_workaround_ops or ahci_pmp_ipms_set_ops.

Heh, maybe.  ahci_pmp_workaround_softreset is a bit generic but at
least doesn't completely stupid.  I don't know. :)

Thanks.

--=20
tejun
