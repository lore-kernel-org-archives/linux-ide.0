From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: flash as hda causes 2.4.18 to hang in grok_partitions()...add_to_page_cache_unique()
Date: Wed, 19 Mar 2003 09:16:31 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0303190914300.2998-100000@pcgl.dsa-ac.de>
References: <m3d6koebef.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <m3d6koebef.fsf@bfnet.com>
List-Id: linux-ide@vger.kernel.org
To: David Wuertele <dave-gnus@bfnet.com>
Cc: kernelnewbies@nl.linux.org, linux-ide@vger.kernel.org

> Guennadi> Try a 2.4.21-pre4-ac4 at least. It fixed our problems with
> Guennadi> flash in true IDE mode here.
>
> Thanks.  Do you know what the change was?  Was patch-2.4.21-pre4-ac4
> the actual patch to fix the problem for you?

No, not really. I posted a question on LKML and Alan told me to try the
patch he released the day before:-) And it worked like a charm:-) So, yes,
it was that actual patch.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

