From: David Wuertele <dave-gnus@bfnet.com>
Subject: Re: flash as hda causes 2.4.18 to hang in
 grok_partitions()...add_to_page_cache_unique()
Date: Tue, 18 Mar 2003 11:13:12 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <m3d6koebef.fsf@bfnet.com>
References: <Pine.LNX.4.33.0303181157440.2998-100000@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0303181157440.2998-100000@pcgl.dsa-ac.de> (Guennadi
 Liakhovetski's message of "Tue, 18 Mar 2003 11:59:23 +0100 (CET)")
List-Id: linux-ide@vger.kernel.org
To: Guennadi Liakhovetski <gl@dsa-ac.de>
Cc: kernelnewbies@nl.linux.org, linux-ide@vger.kernel.org

Guennadi> Try a 2.4.21-pre4-ac4 at least. It fixed our problems with
Guennadi> flash in true IDE mode here.

Thanks.  Do you know what the change was?  Was patch-2.4.21-pre4-ac4
the actual patch to fix the problem for you?

Dave
