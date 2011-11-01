From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 02/15] ATA : vortex86 : fix vortex86dx/sx hardware CRC
 bug.
Date: Tue, 1 Nov 2011 01:02:42 +0000
Message-ID: <20111101010242.003738e9@lxorguk.ukuu.org.uk>
References: <1319602564-19162-1-git-send-email-paul.s.schilling@gmail.com>
	<20111027084310.2b7da753@pyx>
	<CAC=G6sz=PkDoODYh4beT_eRhkm+ZhUxtLnrBXPPuFJW3n+6Vcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAC=G6sz=PkDoODYh4beT_eRhkm+ZhUxtLnrBXPPuFJW3n+6Vcg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Paul Schilling <paul.s.schilling@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, 31 Oct 2011 14:07:45 -0500
Paul Schilling <paul.s.schilling@gmail.com> wrote:

> Hi,
> 
> When I developed this patch for the Vortex86dx.  I recall trying many
> combinations of udma and mwdma.  At the time I developed it, I came
> to the conclusion that both udma and mwdma both failed with CRC
> errors being reported.

MWDMA does not have a CRC so that seems unlikely. If you can re-test and
we can figure out what is going on that would be useful.

Alan
