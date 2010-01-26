From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Tue, 26 Jan 2010 21:27:40 +0100
Message-ID: <20100126202740.GA7248@1wt.eu>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com> <20100126160243.018b87e3@lxorguk.ukuu.org.uk> <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752095Ab0AZUdq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vishal Rao <vishalrao@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Jan 26, 2010 at 09:49:18PM +0530, Vishal Rao wrote:
> At least one user of Intel SSDs reports no issues with existing
> kernels and I've read that
> they do NCQ right.

FWIW, I can confirm that both the 40 and 80 GB X25-M V2 work like
a charm on 2.6.32 here (main desktop and netbook).

Willy
