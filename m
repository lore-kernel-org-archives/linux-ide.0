Return-Path: <SRS0=hzpW=3B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C04C32771
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 05:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66E220848
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 05:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgALF07 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jan 2020 00:26:59 -0500
Received: from mail3.iservicesmail.com ([217.130.24.75]:27409 "EHLO
        mail3.iservicesmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgALF07 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jan 2020 00:26:59 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 00:26:58 EST
IronPort-SDR: LxlmKZM/xK0uRD4dpvS29jA7g8dnMrT2b6/tv9/wSXNvAaIvttwuRF01+VySgv1yK7osuSU9w0
 lNyTOsQESwjA==
IronPort-PHdr: =?us-ascii?q?9a23=3A8lIDxRRq8/C66ufGMHS7CCnB69psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6ybBON2/xhgRfzUJnB7Loc0qyK6vumAzJeqsbd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUbgIpvJqkyxx?=
 =?us-ascii?q?bGv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/GfQhsJtkK1Uuhehphxmz4PKZ4GVLuJ+fqTHfdwAWW?=
 =?us-ascii?q?pOQN9dWDJHAo+lc4YPE/YBMvxEoIn9uVQOqAWxBQ+wBO/21DBIgGb606o90+?=
 =?us-ascii?q?QnDw7H3BUsEMwIsH/JqNn4OrseXfywwKTO0D7Nbe5Z2S3l5YbGch4hu++CU7?=
 =?us-ascii?q?Ftf8Xe1UYhGBjIjkmSpIP5Iz+ZyvgBv3ad4uF9VeyvkWknqwRprza12Mgslp?=
 =?us-ascii?q?fGhpgIwV/E8iV5xok1LsC/RU5jf9GkDIVftzuUNotxRMMiTHpluCYhyrIdpZ?=
 =?us-ascii?q?G3ZjQFyJMixxLFa/yHcJGF7xT+X+iSOTd1nGxpdK+9ihqo7EStxPHwWtOq3F?=
 =?us-ascii?q?tFtCZInNnBu3YQ3BLJ8MeHUOFy/kK51DaK0ADc9/9LLFgvlareN54h2rkwlo?=
 =?us-ascii?q?cPsUjbHi/5hkH2jKiOe0Uh4Oeo6uDnYq/4qZ+YK4N5hRvyMropmsOiG+s4PA?=
 =?us-ascii?q?8OX26F9uimyrLj5lX1QLRMjvIojqnUqI7WKdkZq6KjHgNY3Jov5wyhAzqpyt?=
 =?us-ascii?q?gVk3kKIEpAeB2djojpP1/OIOr/Dfe6m1msiClkx+zYMb37DJTNKX7DkLj6cL?=
 =?us-ascii?q?Z98E5T0xY8wcpD6JJTD7ENOvLzWkzpuNzCEhA5KxC0w/rgCNhl0oMeWGSPAr?=
 =?us-ascii?q?KWMa/LsF+H+/wgLvKSZI8apjn9MeIp5/3wgn8jn18SY62p0YEQaHCiEfQ1a3?=
 =?us-ascii?q?meNH7thMoRVGYGsyIgQ+Hwzl6PSzheYzC1Ra1v3DwjDJOaCtL7S5ygmvS+2y?=
 =?us-ascii?q?G0VslOa3xLEE+LF3jodIWfUfwkZyebI8snmTsBA+uPUYgkgCmjqALgg4VgKO?=
 =?us-ascii?q?WcrjUVqZ/5y99z6MXTjhs5szdzCoKd0DfeHClPgmoUSmpvj+hEqktnxwLYif?=
 =?us-ascii?q?B1?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GeAgDDrBpelyMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznXYBjQQNDQKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GeAgDDrBpelyMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwgBgSWBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznXYBj?=
 =?us-ascii?q?QQNDQKFHYJKBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,423,1571695200"; 
   d="scan'208";a="303950435"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 12 Jan 2020 06:21:51 +0100
Received: (qmail 24199 invoked from network); 12 Jan 2020 05:00:19 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 12 Jan 2020 05:00:19 -0000
Date:   Sun, 12 Jan 2020 06:00:19 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-ide@vger.kernel.org
Message-ID: <33062925.460714.1578805219825.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

