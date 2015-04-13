From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] ide: remove deprecated use of pci api
Date: Mon, 13 Apr 2015 13:25:30 +0100
Message-ID: <20150413132530.210f1d3b@lxorguk.ukuu.org.uk>
References: <1428579988-10167-1-git-send-email-lambert.quentin@gmail.com>
	<1428579988-10167-2-git-send-email-lambert.quentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428579988-10167-2-git-send-email-lambert.quentin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu,  9 Apr 2015 13:46:27 +0200
Quentin Lambert <lambert.quentin@gmail.com> wrote:

> Replace occurences of the pci api by appropriate call to the dma api.
> 

Drivers/ide is obsolete. It probably ought to go at this point but even
so it exists solely in case of a problem or compatibility issue with
drivers/ata. Cleaning it up without testing all the drivers makes no
sense IMHO. Cleaning it up and testing them doesn't make much sense
either.

Alan
