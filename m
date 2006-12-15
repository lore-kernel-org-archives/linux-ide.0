From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
Date: Sat, 16 Dec 2006 00:55:53 +0059
Message-ID: <45833620.2040902@gmail.com>
References: <200612152335.kBFNZ0tu003064@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030398AbWLOX40@vger.kernel.org>
In-Reply-To: <200612152335.kBFNZ0tu003064@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Applying the trivial patch below on top of 2.6.20-rc1-mm1 should

Yup, Jeff fwd me this yet and it works.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
