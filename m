From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata4.00: failed to get Identify Device Data, Emask 0x1
Date: Tue, 16 Oct 2012 15:58:24 +0100
Message-ID: <20121016155824.00d5b618@pyramind.ukuu.org.uk>
References: <20121016144932.GA24044@aftab.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121016144932.GA24044@aftab.osrc.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, 16 Oct 2012 16:49:32 +0200
Borislav Petkov <bp@amd64.org> wrote:

> Hi all,
> 
> a bunch of my boxes started showing this on 3.7-rc1 (and maybe earlier):
> 
> [    4.667077] ata4.00: failed to get Identify Device Data, Emask 0x1
> [    4.675071] ata4.00: failed to get Identify Device Data, Emask 0x1

Can you check whether 3.6 works on them. I know 3.6 is horribly broken on
several brands of AHCI controller (Jmicron for example). Dunno where Jeff
is on fixing the regressions ?

Alan
