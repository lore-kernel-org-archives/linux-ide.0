From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: IO/MMIO 2.4 ATA/IDE driver recore near complete
Date: Fri, 17 May 2002 04:15:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020517031515.20062@smtp.wanadoo.fr>
References: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org>
List-Id: linux-ide@vger.kernel.org
To: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

>Please note BMDMA for MMIO is not native since there appears to be
>pci-posting errors under x86.

Can you elaborate ? I had to deal with driver bugs related to
PCI wr. posting in the past. I assume you know what you are doing,
but just in case, you missed a SW bug, I may be able to help.

Ben.


