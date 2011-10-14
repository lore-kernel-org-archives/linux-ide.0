From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix for transport xfer attributes
Date: Fri, 14 Oct 2011 20:31:38 +0100
Message-ID: <20111014203138.5d3460d5@lxorguk.ukuu.org.uk>
References: <201110132203.45394.bzolnier@gmail.com>
	<4E9762DE.1060009@pobox.com>
	<201110141158.33983.bzolnier@gmail.com>
	<CANEJEGtzwQkDG1KmqVizmW8=SWuhYgjH02TgLaQzU-76TYUZZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANEJEGtzwQkDG1KmqVizmW8=SWuhYgjH02TgLaQzU-76TYUZZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou ` <gwendal@google.com>
List-Id: linux-ide@vger.kernel.org

>     "xfer_mode   Current transfer mode."
> 
> I agree with Bartomiej that current behavior is incorrect.

Well we should probably fix the document and add the current transfer
mode as its own sysfs entry - much less risky.
