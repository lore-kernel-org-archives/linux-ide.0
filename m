From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Subject: bitrot on wiki [was Re: HP Compaq 2710p notebook suffers too many
 head unloads]
Date: Mon, 7 Jan 2013 12:29:16 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1301071219360.8843@redclaw.mimosa.com>
References: <alpine.LRH.2.02.1301020002520.1546@redclaw.mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-d.mimosa.com ([209.161.207.149]:60574 "EHLO gw-d.mimosa.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228Ab3AGR3U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jan 2013 12:29:20 -0500
Received: from gw-c.mimosa.com (reddoor.mimosa.com [192.139.70.80])
	by gw-d.mimosa.com (8.12.8/8.12.8) with ESMTP id r07HTHh4018814
	for <linux-ide@vger.kernel.org>; Mon, 7 Jan 2013 12:29:17 -0500
Received: from redclaw.mimosa.com (redclaw.mimosa.com. [192.139.70.88])
	by gw-c.mimosa.com (8.12.8/8.12.8) with ESMTP id r07HTHSO010743
	for <linux-ide@vger.kernel.org>; Mon, 7 Jan 2013 12:29:17 -0500
In-Reply-To: <alpine.LRH.2.02.1301020002520.1546@redclaw.mimosa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

| From: D. Hugh Redelmeier <hugh@mimosa.com>
| Date: Wed, 2 Jan 2013 00:50:40 -0500 (EST)

| The head unloading problem is as described here:
| <https://ata.wiki.kernel.org/index.php/Known_issues#Drives_which_perform_frequent_head_unloads_under_Linux>
| 
| I am intending that this report contributes to that table.
| (Aside: many of the links in that table are broken.)

I've added a row for my system.

After the table, there is a section of sorage-fixup.  The links are
all broken.  This leaves us with no suggested work-around.
I've added a note for the crude work-around that I implemented.

It would be good if someone could fix the links.

Wouldn't it be nice if the utility formerly known as Palimpsest and
other S.M.A.R.T. monitoring systems would monitor and warn of this
silent killer?
